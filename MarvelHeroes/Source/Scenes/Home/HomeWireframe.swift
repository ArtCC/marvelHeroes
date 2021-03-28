//
//  HomeWireframe.swift
//  MarvelHeroes
//
//  Created Arturo Carretero Calvo on 15/06/2020.
//  Copyright © 2020 Arturo Carretero Calvo. All rights reserved.
//

import UIKit

/// Wireframe protocol to define routing to other scenes.
protocol HomeWireframe: class {

  func navigateToDetailScene(character: Character)
}

// MARK: - UIViewController extension to implement wireframe protocol.

extension HomeViewController: HomeWireframe {

  func navigateToDetailScene(character: Character) {
    guard let detailViewController = DetailConfigurator.shared.preparedViewController() as? DetailViewController else { return }
    detailViewController.presenter?.character = character
    self.present(detailViewController, animated: true, completion: nil)
  }

  /// Override prepare(forsegue) method to configure next scene.
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {}
}
