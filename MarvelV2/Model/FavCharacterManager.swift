//
//  FavCharacterManager.swift
//  MarvelV2
//
//  Created by DISMOV on 10/05/24.
//

import Foundation
import CoreData

class FavCharacterManager {
    private var favCharacters : [FavCharacter] = []
    private var context : NSManagedObjectContext
    
    init(context : NSManagedObjectContext) {
        self.context = context
    }
    
    func fetch() {
        do {
            self.favCharacters = try self.context.fetch(FavCharacter.fetchRequest())
        }
        catch let error {
            print("error: ", error)
        }
    }
    
    func countFavCharacters() -> Int {
        return favCharacters.count
    }
    
    func getfavCharacter(at index: Int) -> FavCharacter {
        return favCharacters[index]
    }
    
    func fetchById(searchValue : Int) {
        do {
            let fetchRequestWP = NSFetchRequest<FavCharacter>(entityName: "FavCharacter")
            fetchRequestWP.predicate = NSPredicate(format: "id = %@", NSNumber(integerLiteral: searchValue))
            print(fetchRequestWP)
            self.favCharacters = try self.context.fetch(fetchRequestWP)
        }
        catch let error{
            print("error: ", error)
        }
    }
}
