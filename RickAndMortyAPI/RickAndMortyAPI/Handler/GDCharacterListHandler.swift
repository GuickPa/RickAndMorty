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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
}

class GDCharacterListHandler: GDListHandler {
    let decoder: GDDataDecoder
    var characterList: GDCharacterList?
    
    var list: GDCharacterList? {
        get {
            return characterList
        }
    }
    
    init(decoder: GDDataDecoder) {
        self.decoder = decoder
    }
    
    func listFromData(_ data: Data) {
        self.characterList = self.decoder.decode(data: data, classType: GDCharacterList.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return self.characterList?.info.count ?? 0
        self.characterList?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GDCharacterTableViewCell.reuseIdentifier, for: indexPath) as! GDCharacterTableViewCell
        cell.contentView.backgroundColor = indexPath.row % 2 == 0 ? GDConst.characterCellBGColor0 : GDConst.characterCellBGColor1
        if let character = self.characterList?.results[indexPath.row] {
            cell.nameLabel.text = character.name
            cell.conditionLabel.text = character.condition()
            cell.genderLabel.text = character.gender
            cell.setupPicView()
            cell.picView?.load(urlToImage: character.image, loader: GDDataLoader(), handler: GDOperationQueueManager.instance)
        }
        
        return cell
    }
}
