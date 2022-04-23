//
//  ViewController.swift
//  RickAndMortyAPI
//
//  Created by Guglielmo Deletis on 20/04/22.
//

import UIKit

protocol GDDetailsLoaderViewController: UIViewController {
    associatedtype T:GDDetailsHandler
    
    var loaders:[GDLoader] { get }
    
    init(loaders:[GDLoader], detailsHandler: T)
}

class GDBaseViewController: UIViewController {
    var loader: GDLoader
    
    init(loader:GDLoader, nibName:String, bundle: Bundle?) {
        self.loader = loader
        super.init(nibName: nibName, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
}

extension GDBaseViewController {
    func showError(_ error: Error) {
        let alert = UIAlertController(title: NSLocalizedString("error_title", comment: "Error"), message: error.localizedDescription, preferredStyle: .alert)
        alert.definesPresentationContext = true
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction) in
            
        } ))
        self.present(alert, animated: true)
    }
}
