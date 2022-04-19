//
//  GDOperation.swift
//  RickAndMortyAPI
//
//  Created by Guglielmo Deletis on 19/04/22.
//

import Foundation

protocol GDOperationHandler {
    var isAsynchronous:Bool { get }
    var isExecuting:Bool { get }
    var isFinished:Bool { get }
    var isCancelled:Bool { get set }
    
    func start()
    func main()
    func cancel()
    func finish()
}

internal class GDOperation: GDOperationHandler {

    private var _isExecuting:Bool = false
    private var _isFinished:Bool = false
    private var _isCancelled:Bool = false
    
    var isAsynchronous: Bool {
        get {
            return false
        }
    }
    
    var isExecuting: Bool {
        get {
            return _isExecuting
        }
    }
    
    var isFinished: Bool {
        get {
            return _isFinished
        }
    }
    
    var isCancelled: Bool {
        get {
            return _isCancelled
        }
        set {
            _isCancelled = newValue
        }
    }
    
    func start() {
        if self.isCancelled {
            _isExecuting = false
            _isFinished = true
            
        }
        else {
            _isExecuting = true
            _isFinished = false
            self.main()
        }
    }
    
    func main() {
        if self.isCancelled {
            self.finish()
        }
        else {
            
        }
    }
    
    func cancel() {
        self.finish()
    }
    
    func finish() {
        _isExecuting = false
        _isFinished = true
    }
}
