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
        // load character list and wait
        self.loadingView.isHidden = false
        self.loader.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
        if let character = self.listHandler.list?.results[indexPath.row] {
            let loader = GDDataLoader()
            let characterHandler = GDCharacterDetailsHandler(characterId: character.id, decoder: GDGenericDataDecoder())
            self.navigationController?.pushViewController(
                GDCharacterViewController(loader: loader, detailsHandler: characterHandler),
                //UIViewController(nibName: "GDCharacterViewController", bundle: nil),
                animated: true
            )
        }
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
