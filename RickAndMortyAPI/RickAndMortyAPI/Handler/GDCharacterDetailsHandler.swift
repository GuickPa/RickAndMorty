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
        let view:GDCharacterItemDetailsView = GDCustomViewLoader.loadView()
        view.setupPicView()
        view.nameLabel.text = self.character.name
        view.picView?.load(urlToImage: self.character.image, loader: GDDataLoader(), handler: GDOperationQueueManager.instance)
        view.setUpConstraint(superView: superView)
        return view
    }
}
