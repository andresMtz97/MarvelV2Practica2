//
//  DetailViewController.swift
//  MarvelV2
//
//  Created by DISMOV on 09/05/24.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    
    @IBOutlet weak var favorites: UIBarButtonItem!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var character: Character?
    var favorite = false

    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var favButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let favoritesManager = FavCharacterManager(context: context)
        favoritesManager.fetchById(searchValue: character?.id ?? 0)
        favorite = favoritesManager.countFavCharacters() > 0
        
        if favorite {
            favButton.image = UIImage(systemName: "star.fill")
        }
        
        if let marvelCharacter = character {
            name.text = marvelCharacter.name
            if marvelCharacter.description.isEmpty {
                descriptionLabel.text = "No description."
            } else {
                descriptionLabel.text = marvelCharacter.description
            }
            thumbnail.sd_setImage(with: URL(string: marvelCharacter.thumbnail.url))
            
            print(marvelCharacter.name)
        }
    }
    
    @IBAction func favBtnTapped(_ sender: UIBarButtonItem) {
        if !favorite {
            let favCharacter = FavCharacter(context: context)
                        
            favCharacter.id = Int32(character?.id ?? 0)
            favCharacter.name = character?.name
            favCharacter.thumbnail = character?.thumbnail.url

            do {
                try context.save()
            } catch let error {
                print("error: ", error)
            }
            
            favButton.image = UIImage(systemName: "star.fill")
        }
    }
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}
