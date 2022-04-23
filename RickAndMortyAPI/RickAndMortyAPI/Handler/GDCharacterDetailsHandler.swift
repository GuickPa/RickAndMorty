//
//  GDCharacterDetailsHandler.swift
//  RickAndMortyAPI
//
//  Created by Guglielmo Deletis on 21/04/22.
//

import Foundation
import UIKit

//MARK: PROTOCOL
protocol GDDetailsHandler {
    associatedtype T
    var item: T { get }
    var itemId: Int { get }
    func detailsFromData(_ data: Data)
    func detailsView(superView:UIView) -> UIView
    init(itemId: Int, decoder: GDDataDecoder)
}

//MARK: GDCharacterDetailsHandler
class GDCharacterDetailsHandler: GDDetailsHandler {
    typealias T = GDCharacter
    let decoder: GDDataDecoder
    var characterItem: GDCharacter!
    var characterItemId: Int
    
    var item: GDCharacter {
        get {
            return characterItem
        }
    }
    
    var itemId: Int {
        get {
            return characterItemId
        }
    }
    
    required init(itemId: Int, decoder: GDDataDecoder) {
        self.characterItemId = itemId
        self.decoder = decoder
    }
    
    func detailsFromData(_ data: Data) {
        self.characterItem = self.decoder.decode(data: data, classType: GDCharacter.self)
    }
    
    func detailsView(superView:UIView) -> UIView {
        let view:GDCharacterItemDetailsView = GDCustomViewLoader.loadView()
        view.setupPicView()
        view.nameLabel.text = self.item.name
        view.conditionLabel.text = self.item.condition()
        view.genderLabel.text = self.item.gender
        view.picView?.load(urlToImage: self.item.image, loader: GDDataLoader(), handler: GDOperationQueueManager.instance)
        view.setUpConstraint(superView: superView)
        return view
    }
}

//MARK: GDLocationDetailsHandler
class GDLocationDetailsHandler: GDDetailsHandler {
    typealias T = GDLocation
    let decoder: GDDataDecoder
    var locationItem: GDLocation!
    var locationItemId: Int
    
    var item: GDLocation {
        get {
            return locationItem
        }
    }
    
    var itemId: Int {
        get {
            return locationItemId
        }
    }
    
    required init(itemId: Int, decoder: GDDataDecoder) {
        self.locationItemId = itemId
        self.decoder = decoder
    }
    
    func detailsFromData(_ data: Data) {
        self.locationItem = self.decoder.decode(data: data, classType: GDLocation.self)
    }
    
    func detailsView(superView:UIView) -> UIView {
        let view:GDLocationItemDetailsView = GDCustomViewLoader.loadView()
        view.originLabel.text = ""
        view.nameLabel.text = self.item.name
        view.typeLabel.text = self.item.type
        view.dimensionLabel.text = self.item.dimension
        view.residentsCountLabel.text = "\(self.item.residents.count)"
        
        view.setUpConstraint(superView: superView)
        return view
    }
}
