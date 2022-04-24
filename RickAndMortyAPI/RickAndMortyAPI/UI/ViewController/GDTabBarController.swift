//
//  GDTabBarViewController.swift
//  RickAndMortyAPI
//
//  Created by Guglielmo Deletis on 23/04/22.
//

import UIKit

class GDTabBarController: UITabBarController {
    
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
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .clear
        self.tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            self.tabBar.scrollEdgeAppearance = self.tabBar.standardAppearance
        }
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
        self.viewControllers = [setupDetailsTab(), setupLocationTab(), setupChapterTab()]
        self.tabBar.items?.indices.forEach{
            let item = self.tabBar.items![$0]
            item.image = UIImage(systemName: "person")
            item.selectedImage = UIImage(systemName: "person.fill")
        }
    }
    
    private func setupDetailsTab() -> UIViewController {
        let vc = GDDetailsViewController(handlers: [GDCharacterDetailsHandler(characterItem: self.character, decoder: GDGenericDataDecoder())])
        vc.title = "Profile"
        return vc
    }
    
    private func setupLocationTab() -> UIViewController {
        let vc = GDDetailsViewController(handlers: [
            GDLocationDetailsHandler(characterItem: self.character, decoder: GDGenericDataDecoder()),
            GDOriginDetailsHandler(characterItem: self.character, decoder: GDGenericDataDecoder()),
        ])
        
        vc.title = "Origin and Location"
        return vc
    }
    
    private func setupChapterTab() -> UIViewController {
        let vc = GDDetailsViewController(handlers: [GDChapterDetailsHandler(characterItem: self.character, decoder: GDGenericDataDecoder())])
        
        vc.title = "Episodes"
        return vc
    }
}
