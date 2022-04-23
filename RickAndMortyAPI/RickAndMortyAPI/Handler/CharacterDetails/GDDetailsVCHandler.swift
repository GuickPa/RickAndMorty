//
//  GDDetailsVCHandler.swift
//  RickAndMortyAPI
//
//  Created by Guglielmo Deletis on 23/04/22.
//

import UIKit

protocol GDDetailsVCHandler: UIViewController {
    var characterItem: GDCharacter { get }
    
    init(characterItem: GDCharacter)
}
