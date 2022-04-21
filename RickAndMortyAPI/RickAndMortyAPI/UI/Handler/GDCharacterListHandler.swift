//
//  GDCharacterListHandler.swift
//  RickAndMortyAPI
//
//  Created by Guglielmo Deletis on 20/04/22.
//

import UIKit

protocol GDListHandler {
    var list: GDCharacterList { get }
    func listFromData(_ data: Data)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
}

class GDCharacterListHandler: GDListHandler {
    let decoder: GDDataDecoder
    private var characterList: GDCharacterList!
    
    var list: GDCharacterList {
        get {
            return characterList
        }
    }
    
    init(decoder: GDDataDecoder) {
        self.decoder = decoder
    }
    
    func listFromData(_ data: Data) {
        self.characterList = self.decoder.decode(data: data)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.characterList.info.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let character = self.characterList.results[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: GDCharacterTableViewCell.reuseIdentifier, for: indexPath) as! GDCharacterTableViewCell
        
        cell.nameLabel.text = character.name
        
        return cell
    }
}
