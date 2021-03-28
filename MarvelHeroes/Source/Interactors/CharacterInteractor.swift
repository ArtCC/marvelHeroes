//
//  CharacterInteractor.swift
//  MarvelHeroes
//
//  Created by Arturo Carretero Calvo on 15/06/2020.
//  Copyright © 2020 Arturo Carretero Calvo. All rights reserved.
//

import UIKit

/// Enum for result.
enum CharacterResult: Int {

  case success, error
}

protocol CharacterInteractor {

  /// Get all characters
  /// - Parameters:
  ///   - page: page for request and pagination
  ///   - nameStartsWith: for custom request
  ///   - output: array with characters or nil
  func retrieveCharacters(page: Int,
                          nameStartsWith: String?,
                          output: @escaping(_ result: CharacterResult, _ characters: [Character]?) -> Void)
}
