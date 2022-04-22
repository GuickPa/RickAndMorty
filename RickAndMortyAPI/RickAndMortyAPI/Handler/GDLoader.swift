//
//  GDCharacterListLoader.swift
//  RickAndMortyAPI
//
//  Created by Guglielmo Deletis on 20/04/22.
//

import Foundation

protocol GDLoader {
    var delegate: GDLoaderDelegate! { get set }
    func load(urlString: String, handler: GDOperationQueueHandler)
    func cancel()
}

protocol GDLoaderDelegate: AnyObject {
    func loaderDidStart(_ loader: GDLoader)
    func loaderDidLoad(_ loader: GDLoader, data: Data?)
    func loaderFailed(_ loader: GDLoader, error: Error)
}

class GDDataLoader {
    weak var _delegate: GDLoaderDelegate!
    var operation: GDOperation!
    
    var delegate: GDLoaderDelegate! {
        get {
            return _delegate
        }
        set {
            _delegate = newValue
        }
    }
}

//MARK: GDLoader
extension GDDataLoader: GDLoader {
    func load(urlString: String, handler: GDOperationQueueHandler) {
        do {
            let action = try GDAPIOperationAction(urlString, method: .get)
            self.operation = GDOperation(withAction: action, delegate: self)
            handler.addToQueue(self.operation)
        }
        catch let ex {
            self.delegate.loaderFailed(self, error: ex)
        }
    }
    
    func cancel() {
        self.operation.cancel()
        self.operation = nil
    }
}

//MARK: GDOperationDelegate
extension GDDataLoader: GDOperationDelegate {
    func operationStarted(_ operation: GDOperation) {
        self.delegate.loaderDidStart(self)
    }
    
    func operationCompleted(_ operation: GDOperation, withData data: Data?) {
        self.delegate.loaderDidLoad(self, data: data)
        self.operation = nil
    }
    
    func operationFailed(_ operation: GDOperation, withError error: Error?) {
        self.delegate.loaderFailed(self, error: error!)
        self.operation = nil
    }
    
    func operationCancelled(_ operation: GDOperation) {
        self.delegate.loaderFailed(self, error: GDError.aborted)
        self.operation = nil
    }
}
