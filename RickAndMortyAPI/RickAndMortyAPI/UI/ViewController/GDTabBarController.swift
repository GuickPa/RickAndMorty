//
//  GDTabBarViewController.swift
//  RickAndMortyAPI
//
//  Created by Guglielmo Deletis on 23/04/22.
//

import UIKit

class GDTabBarController: UITabBarController, GDDetailsVCHandler {
    
    private var character: GDCharacter
    
    var characterItem: GDCharacter {
        get {
            return character
        }
    }
    
    required init(characterItem: GDCharacter) {
        self.character = characterItem
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupTabs()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    private func setupTabs() {
        self.viewControllers = [setupCharacterTab(), setupLocationTab()]
    }
    
    private func setupCharacterTab() -> GDBaseViewController {
        let loader = GDDataLoader()
        let characterHandler = GDCharacterDetailsHandler(itemId: character.id, decoder: GDGenericDataDecoder())
        return GDCharacterViewController(loader: loader, detailsHandler: characterHandler)
    }
    
    private func setupLocationTab() -> GDBaseViewController {
        let loader = GDDataLoader()
        let id = Int(character.location.url.lastPathComponent())!
        let characterHandler = GDLocationDetailsHandler(itemId: id, decoder: GDGenericDataDecoder())
        return GDLocationViewController(loader: loader, detailsHandler: characterHandler)
    }

}
