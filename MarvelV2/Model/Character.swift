//
//  Character.swift
//  MarvelV2
//
//  Created by DISMOV on 09/05/24.
//

import Foundation

struct Character: Codable {
    let id: Int
    let name: String
    let description: String
    let modified: String
    let resourceURI: String
    let thumbnail: Image
    let urls: [URLWebSite]
    let comics: ResourceList<ComicItem>
    let stories: ResourceList<StoryItem>
    let events: ResourceList<EventItem>
    let series: ResourceList<SerieItem>
}
