//
//  HomeView.swift
//  MarvelHeroes
//
//  Created Arturo Carretero Calvo on 15/06/2020.
//  Copyright © 2020 Arturo Carretero Calvo. All rights reserved.
//

import Foundation

/// Presenter implementation to handle abstract scene view logic.
protocol HomeView: ViewProtocol {

  func show(characters: [Character])
  func showCharactersFromSearch(characters: [Character])
  func addNewCharacters(characters: [Character])
  func empty()
}
