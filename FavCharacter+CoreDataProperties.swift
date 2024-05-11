//
//  FavCharacter+CoreDataProperties.swift
//  MarvelV2
//
//  Created by DISMOV on 10/05/24.
//
//

import Foundation
import CoreData


extension FavCharacter {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavCharacter> {
        return NSFetchRequest<FavCharacter>(entityName: "FavCharacter")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var thumbnail: String?

}

extension FavCharacter : Identifiable {

}
