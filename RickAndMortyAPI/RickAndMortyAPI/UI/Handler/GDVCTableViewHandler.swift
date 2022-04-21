//
//  File.swift
//  RickAndMortyAPI
//
//  Created by Guglielmo Deletis on 20/04/22.
//

import UIKit

protocol GDVCTableViewDataSource: UITableViewDataSource {
    associatedtype GDItem
    func load()
    func item(forIndexPath indexPath: IndexPath) -> GDItem
}

protocol GDVCTableViewDelegate: UITableViewDelegate {
    
}
