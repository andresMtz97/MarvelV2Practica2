//
//  FavoritesViewController.swift
//  MarvelV2
//
//  Created by DISMOV on 10/05/24.
//

import UIKit

class FavoritesViewController: UIViewController {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var favoritesManager: FavCharacterManager? = nil
    
    @IBOutlet weak var favCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favCollectionView.dataSource = self
        favCollectionView.delegate = self
        
        favoritesManager = FavCharacterManager(context: context)
        
        favoritesManager?.fetch()
        
        print(favoritesManager?.countFavCharacters() ?? 0)

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FavoritesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoritesManager?.countFavCharacters() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CharacterCell
        let character = favoritesManager?.getfavCharacter(at: indexPath.row)
        cell.name.text = character?.name
        let url = URL(string: (character?.thumbnail)!)
        cell.image.sd_setImage(with: url)
        
        return cell
    }
}
