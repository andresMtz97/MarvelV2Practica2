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
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var character: Character?
    var favorite = false

    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var favButton: UIBarButtonItem!
    @IBOutlet weak var urlBtn: UIButton!
    
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
            
            if let countUrls = character?.urls.count {
                urlBtn.setTitle(character?.urls[countUrls - 1].url, for: .normal)
            }
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
    
    @IBAction func urlTapped(_ sender: UIButton) {
        if appDelegate.internetStatus {
            if let url = URL(string: sender.title(for: .normal) ?? "") {
                UIApplication.shared.open(url)
            }
        } else {
            print("Sin conexión a internet")
        }
    }
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}
