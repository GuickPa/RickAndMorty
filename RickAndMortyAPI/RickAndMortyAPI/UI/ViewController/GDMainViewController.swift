//
//  GDMainViewController.swift
//  RickAndMortyAPI
//
//  Created by Guglielmo Deletis on 20/04/22.
//

import UIKit

class GDMainViewController: GDBaseViewController {
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var loadingView: UIView!
    private var listHandler: GDListHandler
    
    init(loader:GDLoader, listHandler: GDListHandler) {
        self.listHandler = listHandler
        super.init(loader: loader, nibName: "GDMainViewController", bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainTableView.register(
            UINib(nibName: "GDCharacterTableViewCell", bundle: nil),
            forCellReuseIdentifier: GDCharacterTableViewCell.reuseIdentifier
        )
        // load character list
        self.loadingView.isHidden = false
        self.loader.delegate = self
        self.loader.load(urlString: GDConst.characterListURLString, handler: GDOperationQueueManager.instance)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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

//MARK: UITableViewDataSourcePrefetching
extension GDMainViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if let index = indexPaths.first(where: {
            let page = ($0.row / GDConst.characterListDefaultPageCount) + 1
            return self.listHandler.shouldLoadPage(index: page)
        }) {
            let page = (index.row / GDConst.characterListDefaultPageCount) + 1
            self.loader.load(urlString: String(format: GDConst.characterListPageURLString, page), handler: GDOperationQueueManager.instance)
        }
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        self.loader.cancel()
        self.loadingView.isHidden = true
    }
}

//MARK: UITableViewDelegate
extension GDMainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let character = self.listHandler.getCharacter(byIndex: indexPath.row) {
            let tbvc = GDTabBarController(characterItem: character)
            self.navigationController?.pushViewController(tbvc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.listHandler.tableView(tableView, willDisplay: cell, forRowAt: indexPath)
    }
}

//MARK: GDLoaderDelegate
extension GDMainViewController: GDLoaderDelegate {
    func loaderDidStart(_ loader: GDLoader) {
        DispatchQueue.main.async {
            self.loadingView.isHidden = false
        }
    }
    
    func loaderDidLoad(_ loader: GDLoader, data: [Data]?) {
        if let d = data?[0] {
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
    
    func loaderCancelled(_ loader: GDLoader) {
        DispatchQueue.main.async {
            self.loadingView.isHidden = true
        }
    }
}
