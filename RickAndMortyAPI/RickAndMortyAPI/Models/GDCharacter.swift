//
//  GDCharacter.swift
//  RickAndMortyAPI
//
//  Created by Guglielmo Deletis on 20/04/22.
//

import Foundation

struct GDCharacterOrigin: Codable {
    var name: String
    var url: String
}

struct GDCharacterLocation: Codable {
    var name: String
    var url: String
}

struct GDCharacterListItem: Codable {
    var id: Int
    var name: String
    var status: String
    var species: String
    var type: String
    var gender: String
    var origin: GDCharacterOrigin
    var location: GDCharacterLocation
    var image: String
    var episode: [String]
    var url: String
    var created: String
}

struct GDCharacterListInfo: Codable {
    var count: Int
    var pages: Int
    var next: String?
    var prev: String?
}

struct GDCharacterList: Codable {
    var info: GDCharacterListInfo
    var results: [GDCharacterListItem]
}

struct GDLocation: Codable {
    var id: Int
    var name: String
    var type: String
    var dimension: String
    var residents: [String]
    var url: String
    var created: String
}

struct GDEpisode: Codable {
    var id: Int
    var name: String
    var air_date: String
    var episode: String
    var characters: [String]
    var url: String
    var created: String
}
