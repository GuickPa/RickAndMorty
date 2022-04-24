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
    var characterItem: GDCharacter { get }
    func detailsFromData(_ data: Data)
    func detailsView() -> UIView
    func fillView()
    func load(loader: GDLoader)
    init(characterItem: GDCharacter, decoder: GDDataDecoder)
}

//MARK: GDCharacterDetailsHandler
class GDCharacterDetailsHandler: GDDetailsHandler {
    let decoder: GDDataDecoder
    var character: GDCharacter
    weak var mainView:GDCharacterItemDetailsView!
    
    var characterItem: GDCharacter {
        get {
            return character
        }
    }
    
    required init(characterItem: GDCharacter, decoder: GDDataDecoder) {
        self.character = characterItem
        self.decoder = decoder
    }
    
    func detailsFromData(_ data: Data) {
        self.character = self.decoder.decode(data: data, classType: GDCharacter.self)!
    }
    
    func detailsView() -> UIView {
        let view:GDCharacterItemDetailsView = GDCustomViewLoader.loadView()
        view.setupPicView()
        view.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
        self.mainView = view
        return view
    }
    
    func load(loader: GDLoader) {
        // no needs to load
        fillView()
    }
    
    func fillView() {
        self.mainView.nameLabel.text = self.character.name
        self.mainView.conditionLabel.text = self.character.condition()
        self.mainView.genderLabel.text = self.character.gender
        self.mainView.picView?.load(urlToImage: self.character.image, loader: GDDataLoader(), handler: GDOperationQueueManager.instance)
    }
}

//MARK: GDLocationDetailsHandler
class GDLocationDetailsHandler: GDDetailsHandler {
    let decoder: GDDataDecoder
    var character: GDCharacter
    var location: GDLocation!
    weak var mainView: GDLocationItemDetailsView!
    var loader:GDLoader!
    
    var characterItem: GDCharacter {
        get {
            return character
        }
    }
    
    required init(characterItem: GDCharacter, decoder: GDDataDecoder) {
        self.character = characterItem
        self.decoder = decoder
    }
    
    func detailsFromData(_ data: Data) {
        self.location = self.decoder.decode(data: data, classType: GDLocation.self)
    }
    
    func detailsView() -> UIView {
        let view:GDLocationItemDetailsView = GDCustomViewLoader.loadView()
        view.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
        self.mainView = view
        return view
    }
    
    func load(loader: GDLoader) {
        self.loader = loader
        self.loader.delegate = self
        self.loader.load(urlString: self.character.location.url, handler: GDOperationQueueManager.instance)
    }
    
    func fillView() {
        self.mainView.nameLabel.text = self.location.name
        self.mainView.typeLabel.text = self.location.type
        self.mainView.dimensionLabel.text = self.location.dimension
        self.mainView.residentsCountLabel.text = "\(self.location.residents.count)"
    }
}

extension GDLocationDetailsHandler: GDLoaderDelegate {
    func loaderDidStart(_ loader: GDLoader) {
        // TODO: show loading?
    }
    
    func loaderDidLoad(_ loader: GDLoader, data: [Data]?) {
        if let d = data?[0] {
            self.detailsFromData(d)
            DispatchQueue.main.async {
                self.fillView()
            }
        }
    }
    
    func loaderFailed(_ loader: GDLoader, error: Error) {
        self.mainView.nameLabel.text = GDConst.messageUnknown
        self.mainView.typeLabel.text = GDConst.messageUnknown
        self.mainView.dimensionLabel.text = GDConst.messageUnknown
        self.mainView.residentsCountLabel.text = GDConst.messageUnknown
    }
}

//MARK: GDLocationDetailsHandler
class GDOriginDetailsHandler: GDDetailsHandler {
    let decoder: GDDataDecoder
    var character: GDCharacter
    var location: GDLocation!
    weak var mainView: GDOriginDetailsView!
    var loader:GDLoader!
    
    var characterItem: GDCharacter {
        get {
            return character
        }
    }
    
    required init(characterItem: GDCharacter, decoder: GDDataDecoder) {
        self.character = characterItem
        self.decoder = decoder
    }
    
    func detailsFromData(_ data: Data) {
        self.location = self.decoder.decode(data: data, classType: GDLocation.self)
    }
    
    func detailsView() -> UIView {
        let view:GDOriginDetailsView = GDCustomViewLoader.loadView()
        view.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
        self.mainView = view
        return view
    }
    
    func load(loader: GDLoader) {
        self.loader = loader
        self.loader.delegate = self
        self.loader.load(urlString: self.character.location.url, handler: GDOperationQueueManager.instance)
    }
    
    func fillView() {
        self.mainView.originLabel.text = self.location.name
    }
}

extension GDOriginDetailsHandler: GDLoaderDelegate {
    func loaderDidStart(_ loader: GDLoader) {
        // TODO: show loading?
    }
    
    func loaderDidLoad(_ loader: GDLoader, data: [Data]?) {
        if let d = data?[0] {
            self.detailsFromData(d)
            DispatchQueue.main.async {
                self.fillView()
            }
        }
    }
    
    func loaderFailed(_ loader: GDLoader, error: Error) {
        self.mainView.originLabel.text = GDConst.messageUnknown
    }
}

//MARK: GDChapterDetailsHandler
class GDChapterDetailsHandler: NSObject, GDDetailsHandler {
    let decoder: GDDataDecoder
    var character: GDCharacter
    var chapters: [GDEpisode]!
    var chaptersData: [Data] = []
    weak var mainView: GDChaptersDetailsView!
    var loader:GDLoader!
    
    var characterItem: GDCharacter {
        get {
            return character
        }
    }
    
    required init(characterItem: GDCharacter, decoder: GDDataDecoder) {
        self.character = characterItem
        self.decoder = decoder
    }
    
    func detailsFromData(_ data: Data) {
        self.chapters = self.chaptersData.map{ self.decoder.decode(data: $0, classType: GDEpisode.self)! }
        self.chaptersData = []
    }
    
    func detailsView() -> UIView {
        let view:GDChaptersDetailsView = GDCustomViewLoader.loadView()
        self.mainView = view
        self.mainView.tableView.register(UINib(nibName: "GDChapterTableViewCell", bundle: nil), forCellReuseIdentifier: GDChapterTableViewCell.reuseIdentifier)
        return view
    }
    
    func load(loader: GDLoader) {
        self.loader = loader
        self.loader.delegate = self
        self.loader.load(urlStrings: self.character.episode, handler: GDOperationQueueManager.instance)
    }
    
    func fillView() {
        self.mainView.tableView.dataSource = self
        self.mainView.tableView.reloadData()
    }
}

extension GDChapterDetailsHandler: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chapters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GDChapterTableViewCell.reuseIdentifier) as! GDChapterTableViewCell
        cell.titleLabel.text = self.chapters[indexPath.row].name
        
        return cell
    }
}

extension GDChapterDetailsHandler: GDLoaderDelegate {
    func loaderDidStart(_ loader: GDLoader) {
        
    }
    
    func loaderDidLoad(_ loader: GDLoader, data: [Data]?) {
        self.chaptersData = data!
        if self.chaptersData.count == self.character.episode.count {
            self.detailsFromData(self.chaptersData[0])
            DispatchQueue.main.async {
                self.fillView()
            }
        }
    }
    
    func loaderFailed(_ loader: GDLoader, error: Error) {
        
    }
}
