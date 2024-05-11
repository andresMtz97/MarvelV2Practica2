//
//  ResourceList.swift
//  MarvelV2
//
//  Created by DISMOV on 09/05/24.
//

import Foundation

struct ResourceList<T: Codable>: Codable {
    let available: Int
    let collectionURI: String
    let items: [T]
    let returned: Int
}
