//
//  GDSessionManager.swift
//  RickAndMortyAPI
//
//  Created by Guglielmo Deletis on 19/04/22.
//

import Foundation

protocol GDSessionHandler {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

class GDSessionManager: GDSessionHandler {
    // for singleton
    private static let _instance: GDSessionManager = GDSessionManager()
    static var instance: GDSessionManager {
        get {
            return _instance
        }
    }
    
    // url session
    private var session: URLSession
    
    private init() {
        self.session = URLSession(configuration: .default)
    }
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.session.dataTask(with: request, completionHandler: completionHandler)
    }
}
