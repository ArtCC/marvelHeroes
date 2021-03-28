//
//  SessionManager.swift
//  MarvelHeroes
//
//  Created by Arturo Carretero Calvo on 15/06/2020.
//  Copyright © 2020 Arturo Carretero Calvo. All rights reserved.
//

import UIKit

class SessionManager: NSObject {
  
  static let shared = SessionManager()
  
  var characters: [Character]?
}
