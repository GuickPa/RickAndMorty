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
        var lastView:UIView? = nil
        self.detailsHandlers.forEach{
            let subview = $0.detailsView()
            self.view.addSubview(subview)
            if ($0.matchParent) {
                self.matchParent(subview)
            } else {
                self.stack(subview, lastView: lastView)
            }
            $0.load(loader: GDDataLoader())
            lastView = subview
        }
    }
    
    func matchParent(_ view: UIView) {
        view.setUpConstraint(superView: self.view)
    }
    
    func stack(_ view: UIView, lastView: UIView?) {
        view.setUpConstraint(toTopView: lastView, superView: self.view)
    }
}
