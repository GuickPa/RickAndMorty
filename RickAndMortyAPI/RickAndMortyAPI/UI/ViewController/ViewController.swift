//
//  ViewController.swift
//  RickAndMortyAPI
//
//  Created by Guglielmo Deletis on 20/04/22.
//

import UIKit

extension UIViewController {
    func showError(_ error: Error) {
        let alert = UIAlertController(title: NSLocalizedString("error_title", comment: "Error"), message: error.localizedDescription, preferredStyle: .alert)
        alert.definesPresentationContext = true
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction) in
            
        } ))
        self.present(alert, animated: true)
    }
}
