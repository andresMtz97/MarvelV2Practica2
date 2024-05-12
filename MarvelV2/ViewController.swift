//
//  ViewController.swift
//  MarvelV2
//
//  Created by DISMOV on 09/05/24.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    
    @IBOutlet weak var favorites: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var attributionText: UIButton!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var keyLoader = KeyLoader.shared
    var characterManager: CharacterServiceManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(keyLoader.getAPIParams())
        print(keyLoader.getQueryString())
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        characterManager = CharacterServiceManager()
        
        characterManager?.loadCharacterData(queryString: keyLoader.getQueryString(limit: Constants.numberOfItemsRequested, offset: 0)) {
            DispatchQueue.main.async {
                print("Completion executed!!")
                self.collectionView.reloadData()
                self.characterManager?.offset = (self.characterManager?.countCharacter())!
                self.attributionText.setTitle(self.characterManager?.attributionText, for: .normal)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            if let destination = segue.destination as? DetailViewController {
                if let position = collectionView.indexPathsForSelectedItems?[0].row {
                    destination.character = characterManager?.getCharacter(at: position)
                }
            }
        }
    }
    
    @IBAction func favoritesTapped(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "favoritesSegue", sender: self)
    }
    
    
    @IBAction func attributionTextTapped(_ sender: UIButton) {
        if appDelegate.internetStatus {
            if let url = URL(string: "http://marvel.com") {
                UIApplication.shared.open(url)
            }
        } else {
            print("Sin conexión a internet")
        }
    }
}

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (characterManager?.countCharacter())!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CharacterCell
        cell.name.text = characterManager?.getCharacter(at: indexPath.row).name
        let url = URL(string: (characterManager?.getCharacter(at: indexPath.row).thumbnail.url)!)
        cell.image.sd_setImage(with: url)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailSegue", sender: self)
    }
}

extension ViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        ////        size of scrollview content
        //        print("contentSize.height", scrollView.contentSize.height)
        ////        screen's available space for scrollview element
        //        print("bounds.height:", scrollView.bounds.height)
        ////        contentOffset y = contentSize.height - bounds.height
        //        print("contentOffset y:", scrollView.contentOffset.y)
                
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let scrollviewHeight = scrollView.bounds.height
        
        if (offsetY > (contentHeight - scrollviewHeight)) && (!characterManager!.maxItemLoaded && !characterManager!.isLoading ){
            print("calling API...")
            self.characterManager!.isLoading = true
            let queryString = keyLoader.getQueryString(limit: Constants.numberOfItemsRequested, offset: self.characterManager!.offset)
                print("qs:",queryString)
            
            self.characterManager!.loadCharacterData(queryString: queryString){
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    print("char com:",self.characterManager!.countCharacter())
                    print("actual offset: ", self.characterManager!.offset)
                    self.characterManager!.offset = self.characterManager!.countCharacter()
                    print("new offset: ", self.characterManager!.offset)
                    self.characterManager!.isLoading = false
                }
            }
        }
        else{
            print("Don't call API...")
        }
    }
}

