//
//  GDConst.swift
//  RickAndMortyAPI
//
//  Created by Guglielmo Deletis on 20/04/22.
//

import Foundation
import UIKit

class GDConst {
    static let baseURLString = "https://rickandmortyapi.com/api"
    static let characterListURLString = "\(GDConst.baseURLString)/character"
    static let characterDetailsURLString = "\(GDConst.baseURLString)/character/%d"
    
    // colors
    static let characterCellBGColor0 = UIColor(hexString: "3C3E44")
    static let characterCellBGColor1 = UIColor(hexString: "24282F")
}
