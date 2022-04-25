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
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    func shouldLoadPage(index:Int) -> Bool
}

class GDCharacterListHandler: GDListHandler {
    let decoder: GDDataDecoder
    private var characterList: GDCharacterList?
    private var characters: [GDCharacter]
    
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let gdCell = cell as? GDCharacterTableViewCell {
            if indexPath.row < self.characters.count {
                let character = self.characters[indexPath.row]
                self.fillCell(gdCell, withCharacter: character)
            } else {
                gdCell.nameLabel.text = GDConst.localizedString("gd_generic_error")
            }
        }
    }
    
    func fillCell(_ cell: GDCharacterTableViewCell, withCharacter character: GDCharacter) {
        cell.nameLabel.text = character.name
        cell.conditionLabel.text = character.condition()
        cell.genderLabel.text = character.gender
        cell.setupPicView()
        cell.picView?.load(urlToImage: character.image, loader: GDDataLoader(), handler: GDOperationQueueManager.instance)
    }
}

//MARK: prefetch data
extension GDCharacterListHandler {
    func shouldLoadPage(index:Int) -> Bool {
        return index > (self.characters.count / GDConst.characterListDefaultPageCount)
    }
}
