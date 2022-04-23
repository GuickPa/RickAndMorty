//
//  GDCharacterItemDetailsView.swift
//  RickAndMortyAPI
//
//  Created by Guglielmo Deletis on 21/04/22.
//

import UIKit

class GDCharacterItemDetailsView: UIView {
    
    @IBOutlet weak var containerPicView:UIView!
    @IBOutlet weak var nameLabel:UILabel!
    @IBOutlet weak var conditionLabel:UILabel!
    @IBOutlet weak var genderLabel:UILabel!
    weak var picView:GDPicView?
    
    func setupPicView() {
        if self.picView == nil {
            self.picView = GDCustomViewLoader.loadView()
        }
        self.picView?.setUpConstraint(superView: self.containerPicView)
    }
}
