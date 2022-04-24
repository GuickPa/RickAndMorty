//
//  GDCharacterListHandler.swift
//  RickAndMortyAPI
//
//  Created by Guglielmo Deletis on 20/04/22.
//

import UIKit

protocol GDListHandler {
    var list: GDCharacterList? { get }
    func listFromData(_ data: Data)
    func getCharacter(byIndex index: Int) -> GDCharacter?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath], withLoader loader: GDLoader)
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath])
}

class GDCharacterListHandler: GDListHandler {
    let decoder: GDDataDecoder
    private var characterList: GDCharacterList?
    private var characters: [GDCharacter]
    // for paging
    private var prefetchLoader: GDLoader?
    
    var list: GDCharacterList? {
        get {
            return characterList
        }
    }
    
    init(decoder: GDDataDecoder) {
        self.decoder = decoder
        self.characters = []
    }
    
    func listFromData(_ data: Data) {
        let list = self.decoder.decode(data: data, classType: GDCharacterList.self)
        self.characterList = list
        self.characters.append(contentsOf: list!.results)
    }
    
    func getCharacter(byIndex index: Int) -> GDCharacter? {
        if index < self.characters.count {
            return self.characters[index]
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.characterList?.info.count ?? 0
        // return self.characterList?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GDCharacterTableViewCell.reuseIdentifier, for: indexPath) as! GDCharacterTableViewCell
        cell.prepareForReuse()
        cell.contentView.backgroundColor = indexPath.row % 2 == 0 ? GDConst.characterCellBGColor0 : GDConst.characterCellBGColor1
        if self.characters.count > indexPath.row {
            let character = self.characters[indexPath.row]
            cell.nameLabel.text = character.name
            cell.conditionLabel.text = character.condition()
            cell.genderLabel.text = character.gender
            cell.setupPicView()
            cell.picView?.load(urlToImage: character.image, loader: GDDataLoader(), handler: GDOperationQueueManager.instance)
        } else {
            cell.nameLabel.text = GDConst.localizedString("gd_generic_error")
        }
        
        return cell
    }
}

//MARK: prefetch data
extension GDCharacterListHandler {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath], withLoader loader: GDLoader) {
        if let index = indexPaths.first(where: { $0.row >= self.characters.count }), let info = self.characterList?.info {
            let page = info.count / index.row
            self.prefetchLoader = loader
            self.prefetchLoader?.delegate = self
            loader.load(urlString: String(format: GDConst.characterListPageURLString, page), handler: GDOperationQueueManager.instance)
        }
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        if let loader = self.prefetchLoader {
            loader.cancel()
            self.prefetchLoader = nil
        }
    }
}

//MARK: GDLoaderDelegate
extension GDCharacterListHandler: GDLoaderDelegate {
    func loaderDidStart(_ loader: GDLoader) {
    }
    
    func loaderDidLoad(_ loader: GDLoader, data: [Data]?) {
        if let d = data?[0] {
            self.listFromData(d)
        }
    }
    
    func loaderFailed(_ loader: GDLoader, error: Error) {
    }
}

