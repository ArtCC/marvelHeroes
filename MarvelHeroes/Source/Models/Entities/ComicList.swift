//
//  ComicList.swift
//  MarvelHeroes
//
//  Created by Arturo Carretero Calvo on 15/06/2020.
//  Copyright © 2020 Arturo Carretero Calvo. All rights reserved.
//

import UIKit

struct ComicList: Codable {

  var available: Int?
  var returned: Int?
  var collectionURI: String?
  var items: [ComicSummary]?
}
