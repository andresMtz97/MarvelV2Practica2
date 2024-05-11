//
//  Image.swift
//  MarvelV2
//
//  Created by DISMOV on 09/05/24.
//

import Foundation

struct Image: Codable {
    let path: String
    let fileExtension: String
    
    var url: String {
        return path + "." + fileExtension
    }
    
    enum CodingKeys : String, CodingKey{
        case path = "path"
        case fileExtension = "extension"
    }
}
