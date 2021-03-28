//
//  DetailWireframe.swift
//  MarvelHeroes
//
//  Created Arturo Carretero Calvo on 15/06/2020.
//  Copyright © 2020 Arturo Carretero Calvo. All rights reserved.
//

import UIKit

/// Wireframe protocol to define routing to other scenes.
protocol DetailWireframe: class {
}

// MARK: - UIViewController extension to implement wireframe protocol.

extension DetailViewController: DetailWireframe {

  /// Override prepare(forsegue) method to configure next scene.
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {}
}
