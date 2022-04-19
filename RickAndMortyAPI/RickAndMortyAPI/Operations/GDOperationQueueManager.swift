//
//  GDOperationManager.swift
//  RickAndMortyAPI
//
//  Created by Guglielmo Deletis on 19/04/22.
//

import Foundation

protocol GDOperationQueueHandler {
    func addToQueue(_ operation: Operation)
    func clearQueue()
}

class GDOperationQueueManager:GDOperationQueueHandler {
    // for singleton
    private static let _instance: GDOperationQueueManager = GDOperationQueueManager()
    static var instance:GDOperationQueueManager {
        get {
            return _instance
        }
    }
    // queue
    private var queue:OperationQueue
    
    private init(){
        self.queue = OperationQueue()
        self.queue.maxConcurrentOperationCount = 1
    }
    
    func addToQueue(_ operation: Operation) {
        if !operation.isFinished {
            self.queue.addOperation(operation)
        }
        else {
            // AWLogger.log("operation can't be added to queue because it is already finished")
        }
    }
    
    func clearQueue() {
        self.queue.cancelAllOperations()
//        if #available(iOS 13.0, *) {
//            self.queue = OperationQueue()
//            self.queue.maxConcurrentOperationCount = 1
//        }
    }
}
