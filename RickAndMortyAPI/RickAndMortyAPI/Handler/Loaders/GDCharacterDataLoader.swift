//
//  GDCharacterDataLoader.swift
//  RickAndMortyAPI
//
//  Created by Guglielmo Deletis on 23/04/22.
//

import Foundation

enum GDCharacterDataType {
    case personalInfo
    case origin
    case location
    case chapters
}

class GDCharacterDataLoader {
    weak var _delegate: GDLoaderDelegate!
    var operation: GDOperation!
    
    private var dataToLoad: [GDCharacterDataType]
    private var character: GDCharacter
    
    var delegate: GDLoaderDelegate! {
        get {
            return _delegate
        }
        set {
            _delegate = newValue
        }
    }
    
    init(characterItem:GDCharacter, toLoad: [GDCharacterDataType]) {
        self.dataToLoad = toLoad
        self.character = characterItem
    }
}

//MARK: GDLoader
extension GDCharacterDataLoader: GDLoader {
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
extension GDCharacterDataLoader: GDOperationDelegate {
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
