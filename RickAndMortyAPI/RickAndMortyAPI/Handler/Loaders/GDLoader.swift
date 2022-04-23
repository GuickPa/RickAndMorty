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
