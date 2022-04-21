//
//  GDOperationAction.swift
//  RickAndMortyAPI
//
//  Created by Guglielmo Deletis on 20/04/22.
//

import Foundation

typealias GDOperationActionCallback = (Data?, Error?) -> Void

protocol GDOperationAction {
    func main(sessionHandler: GDSessionHandler, callback: @escaping GDOperationActionCallback)
}

enum GDAPIOperationActionMethod: String {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case delete = "DELETE"
}

class GDAPIOperationAction: GDOperationAction {
    private var urlRequest:URLRequest
    private var httpDataTask:URLSessionDataTask!
    private var operationCallback:GDOperationActionCallback!
    private weak var sessionHandler: GDSessionHandler!
    
    init(_ urlString: String, method: GDAPIOperationActionMethod) throws {
        guard let url = URL(string: urlString) else {
            throw GDError.badFormat
        }
        self.urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)
        self.urlRequest.httpMethod = method.rawValue
    }
    
    func main(sessionHandler: GDSessionHandler, callback: @escaping GDOperationActionCallback) {
        self.operationCallback = callback
        self.sessionHandler = sessionHandler
        self.httpDataTask = sessionHandler.dataTask(with: self.urlRequest, completionHandler: { data, response, error in
            self.operationCallback(data, error)
            self.sessionHandler.endDataTask()
        })
        self.httpDataTask.resume()
    }
}
