//
//  MainDataManager.swift
//  master-detail
//
//  Created by Aige Cortasa, Albert on 13/09/2021.
//

import Foundation
import CoreData

class MainDataManager {
    var apiClient: APIClient
    var managedContext: NSManagedObjectContext
    var networkMonitor: NetworkMonitor
    
    init(apiClient: APIClient, managedContext: NSManagedObjectContext, networkMonitor: NetworkMonitor) {
        self.apiClient = apiClient
        self.managedContext = managedContext
        self.networkMonitor = networkMonitor
    }
}

extension MainDataManager: MainDataManagerProtocol {
    func getPosts(completion: @escaping (Result<[Post], Error>) -> Void) {
        if networkMonitor.isNetworkAvailable ?? false {
            apiClient.fetch(with: .get, path: "/posts", body: nil) { (result: Result<[Post], Error>) in
                if case .success(let posts) = result {
                    self.savePostsToCoreData(posts: posts)
                }
                completion(result)
            }
        } else {
            guard let posts = loadPostsFromCoreData() else {
                completion(.failure(NSError(domain: "error loading posts", code: 0)))
                return
            }
            completion(.success(posts))
        }
    }
    
    private func savePostsToCoreData(posts: [Post]) {
        clearCoreDataPosts()
        
        for post in posts {
            let entity = NSEntityDescription.entity(forEntityName: "Posts", in: managedContext)!
            let postData = NSManagedObject(entity: entity, insertInto: managedContext)
            postData.setValue(post.userId, forKeyPath: "userId")
            postData.setValue(post.id, forKeyPath: "id")
            postData.setValue(post.title, forKeyPath: "title")
            postData.setValue(post.body, forKeyPath: "body")
        }

        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    private func loadPostsFromCoreData() -> [Post]? {
        var posts: [NSManagedObject] = []
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Posts")

        do {
            posts = try managedContext.fetch(fetchRequest)
            return posts.map {
                Post(userId: $0.value(forKeyPath: "userId") as? Int ?? 0,
                     id: $0.value(forKeyPath: "id") as? Int ?? 0,
                     title: $0.value(forKeyPath: "title") as? String ?? "",
                     body: $0.value(forKeyPath: "body") as? String ?? "")
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    private func clearCoreDataPosts() {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Posts")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)

        do {
            try managedContext.execute(deleteRequest)
            try managedContext.save()
        } catch {
            print ("There was an error deleting Posts")
        }
    }
}
