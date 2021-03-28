//
//  Image.swift
//  MarvelHeroes
//
//  Created by Arturo Carretero Calvo on 15/06/2020.
//  Copyright © 2020 Arturo Carretero Calvo. All rights reserved.
//

import UIKit

struct Image: Codable {

  var path: String?
  var ext: String?

  var url: String {
    guard let p = path, let e = ext else { return "" }
    return p + "." + e
  }

  enum CodingKeys: String, CodingKey {
    case path
    case ext = "extension"
  }
}
