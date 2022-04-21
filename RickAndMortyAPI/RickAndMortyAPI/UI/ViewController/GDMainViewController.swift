//
//  GDMainViewController.swift
//  RickAndMortyAPI
//
//  Created by Guglielmo Deletis on 20/04/22.
//

import UIKit

class GDMainViewController: UIViewController {
    
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var loadingView: UIView!
    
    private var _loader: GDLoader!
    private var _listHandler: GDListHandler!
    
    var loader: GDLoader {
        get {
            return _loader
        }
        set {
            _loader = newValue
        }
    }
    
    var listHandler: GDListHandler {
        get {
            return _listHandler
        }
        set {
            _listHandler = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loader = GDDataLoader(self)
        self.listHandler = GDCharacterListHandler(decoder: GDCharacterDataDecoder())
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // load character list and wait
        self.loader.load(urlString: GDConst.characterListURLString, handler: GDOperationQueueManager.instance)
    }
}

//MARK: UITableViewDataSource
extension GDMainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listHandler.tableView(tableView, numberOfRowsInSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.listHandler.tableView(tableView, cellForRowAt: indexPath)
    }
}

//MARK: UITableViewDelegate
extension GDMainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

//MARK: GDLoaderDelegate
extension GDMainViewController: GDLoaderDelegate {
    func loaderDidStart(_ loader: GDLoader) {
        DispatchQueue.main.async {
            self.loadingView.isHidden = false
        }
    }
    
    func loaderDidLoad(_ loader: GDLoader, data: Data?) {
        if let d = data {
            self.listHandler.listFromData(d)
        }
        DispatchQueue.main.async {
            self.loadingView.isHidden = true
            self.mainTableView.dataSource = self
            self.mainTableView.delegate = self
            self.mainTableView.reloadData()
        }
    }
    
    func loaderFailed(_ loader: GDLoader, error: Error) {
        DispatchQueue.main.async {
            self.loadingView.isHidden = true
            self.showError(error)
        }
    }
}
