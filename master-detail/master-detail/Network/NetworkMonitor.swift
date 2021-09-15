//
//  Network.swift
//  master-detail
//
//  Created by Aige Cortasa, Albert on 15/09/2021.
//

import Foundation
import Network

class NetworkMonitor {
    static public let shared = NetworkMonitor()
    private var monitor: NWPathMonitor
    private var queue = DispatchQueue.global()
    var isNetworkAvailable: Bool?
    
    private init() {
        self.monitor = NWPathMonitor()
        self.queue = DispatchQueue.global(qos: .background)
        self.monitor.start(queue: queue)
        startMonitoring()
    }
    
    deinit {
        monitor.cancel()
    }
    
    func startMonitoring() {
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                self.isNetworkAvailable = true
           } else {
                self.isNetworkAvailable = false
           }
        }
    }
}
