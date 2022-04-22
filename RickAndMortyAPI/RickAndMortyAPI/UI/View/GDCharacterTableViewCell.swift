//
//  GDCharacterTableViewCell.swift
//  RickAndMortyAPI
//
//  Created by Guglielmo Deletis on 20/04/22.
//

import UIKit

class GDCharacterTableViewCell: UITableViewCell {
    static let reuseIdentifier:String = "character.cell.gd.it"
    
    @IBOutlet weak var containerPicView:UIView!
    @IBOutlet weak var nameLabel:UILabel!
    @IBOutlet weak var conditionLabel:UILabel!
    @IBOutlet weak var locationLabel:UILabel!
    @IBOutlet weak var firstAppearanceLabel:UILabel!
    weak var picView:GDPicView?
    
    func setupPicView() {
        if self.picView == nil {
            self.picView = GDCustomViewLoader.loadView()
        }
        self.picView?.setUpConstraint(superView: self.containerPicView)
        self.needsUpdateConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.nameLabel.text = nil
        self.picView?.imageView.image = nil
    }
}
