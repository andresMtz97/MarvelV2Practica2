//
//  DataResponse.swift
//  MarvelV2
//
//  Created by DISMOV on 09/05/24.
//

import Foundation

struct DataResponse<T : Codable> : Codable {
    let offset : Int
    let limit : Int
    let total : Int
    let count : Int
    let results : [T]
}
