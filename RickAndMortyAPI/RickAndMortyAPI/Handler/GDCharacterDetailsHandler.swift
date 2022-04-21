//
//  GDCharacterDetailsHandler.swift
//  RickAndMortyAPI
//
//  Created by Guglielmo Deletis on 21/04/22.
//

import Foundation
import UIKit

protocol GDDetailsHandler {
    var character: GDCharacterListItem { get }
    var characterId: Int { get }
    func detailsFromData(_ data: Data)
    func detailsView(superView:UIView) -> UIView
}

class GDCharacterDetailsHandler: GDDetailsHandler {
    let decoder: GDDataDecoder
    var characterItem: GDCharacterListItem!
    var characterItemId: Int
    
    var character: GDCharacterListItem {
        get {
            return characterItem
        }
    }
    
    var characterId: Int {
        get {
            return characterItemId
        }
    }
    
    init(characterId: Int, decoder: GDDataDecoder) {
        self.characterItemId = characterId
        self.decoder = decoder
    }
    
    func detailsFromData(_ data: Data) {
        self.characterItem = self.decoder.decode(data: data, classType: GDCharacterListItem.self)
    }
    
    func detailsView(superView:UIView) -> UIView {
        let view = Bundle.main.loadNibNamed("GDCharacterItemDetailsView", owner: nil, options: nil)![0] as! GDCharacterItemDetailsView
        view.nameLabel.text = self.character.name
        
        self.setUpConstraint(view: view, superView: superView)
        return view
    }
    
    func setUpConstraint(view: UIView, superView: UIView) {
        superView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        let top = NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: superView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: superView, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0)
        let left = NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: superView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0)
        let right = NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: superView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0)
        superView.addConstraints([top, bottom, left, right])
    }
}
