//
//  GDDetailsViewController.swift
//  RickAndMortyAPI
//
//  Created by Guglielmo Deletis on 24/04/22.
//

import UIKit

protocol GDDetailsVC: UIViewController {
    init(handlers: [GDDetailsHandler])
}

class GDDetailsViewController: UIViewController, GDDetailsVC {
    @IBOutlet var containerView: UIStackView!
    
    private var detailsHandlers:[GDDetailsHandler] = []
    
    required init(handlers: [GDDetailsHandler]) {
        self.detailsHandlers = handlers
        super.init(nibName: "GDDetailsViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.detailsHandlers.forEach{
            self.containerView.addArrangedSubview($0.detailsView())
            $0.load(loader: GDDataLoader())
        }
    }
}
