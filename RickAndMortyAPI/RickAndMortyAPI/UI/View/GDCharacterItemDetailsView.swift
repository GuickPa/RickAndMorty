//
//  GDCharacterItemDetailsView.swift
//  RickAndMortyAPI
//
//  Created by Guglielmo Deletis on 21/04/22.
//

import UIKit

class GDCharacterItemDetailsView: UIView {
    
    @IBOutlet var nameLabel:UILabel!
    @IBOutlet weak var containerPicView:UIView!
    weak var picView:GDPicView?
    
    func setupPicView() {
        if self.picView == nil {
            self.picView = GDCustomViewLoader.loadView()
        }
        self.picView?.setUpConstraint(superView: self.containerPicView)
    }
}
