//
//  GDCharacterViewController.swift
//  RickAndMortyAPI
//
//  Created by Guglielmo Deletis on 21/04/22.
//

import UIKit

class GDCharacterViewController<T:GDDetailsHandler>: GDBaseViewController {
    private var detailsHandler: T
    
    init(loader:GDLoader, detailsHandler: T) {
        self.detailsHandler = detailsHandler
        super.init(loader: loader, nibName: "GDCharacterViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loader.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // load character list and wait
        self.loader.load(urlString: String(format: GDConst.characterDetailsURLString, self.detailsHandler.itemId), handler: GDOperationQueueManager.instance)
    }
}

//MARK: GDLoaderDelegate
extension GDCharacterViewController: GDLoaderDelegate {
    func loaderDidStart(_ loader: GDLoader) {
    }
    
    func loaderDidLoad(_ loader: GDLoader, data: Data?) {
        if let d = data {
            self.detailsHandler.detailsFromData(d)
        }
        DispatchQueue.main.async {
            _ = self.detailsHandler.detailsView(superView: self.view)
        }
    }
    
    func loaderFailed(_ loader: GDLoader, error: Error) {
        DispatchQueue.main.async {
            self.showError(error)
        }
    }
}
