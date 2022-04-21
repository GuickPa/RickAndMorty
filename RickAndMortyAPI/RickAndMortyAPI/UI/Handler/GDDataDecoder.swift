//
//  GDDataDecoder.swift
//  RickAndMortyAPI
//
//  Created by Guglielmo Deletis on 20/04/22.
//

import Foundation

protocol GDDataDecoder {
    func decode(data: Data) -> GDCharacterList?
}

class GDCharacterDataDecoder: GDDataDecoder {
    func decode(data: Data) -> GDCharacterList? {
        let decoder = JSONDecoder()
        do {
            let list = try decoder.decode(GDCharacterList.self, from: data)
            return list
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
