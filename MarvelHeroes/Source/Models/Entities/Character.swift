//
//  Character.swift
//  MarvelHeroes
//
//  Created by Arturo Carretero Calvo on 15/06/2020.
//  Copyright © 2020 Arturo Carretero Calvo. All rights reserved.
//

import UIKit

struct Character: Codable {
    
    var id: Int?
    var name: String?
    var description: String?
    var modified: Date?
    var resourceURI: String?
    var urls: [Url]?
    var thumbnail: Image?
    var comics: ComicList?
    var stories: StoryList?
    var events: EventList?
    var series: SeriesList?
}
