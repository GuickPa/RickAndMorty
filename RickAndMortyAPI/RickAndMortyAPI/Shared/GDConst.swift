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
    static let characterListPageURLString = "\(GDConst.baseURLString)/character?page=%d"
    static let characterDetailsURLString = "\(GDConst.baseURLString)/character/%d"
    static let locationDetailsURLString = "\(GDConst.baseURLString)/location/%d"
    
    // constants
    static let characterListDefaultPageCount: Int = 20
    
    // colors
    static let defaultBackgroundColor = UIColor(hexString: "3C3E44")
    static let characterCellBGColor0 = UIColor(hexString: "323541")
    static let characterCellBGColor1 = UIColor(hexString: "24282F")
    
    // generic messages
    static let messageUnknown = GDConst.localizedString("gd_message_unknown")
    
    static func localizedString (_ title: String) -> String {
      return NSLocalizedString(title, comment: "")
    }
}
