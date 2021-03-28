//
//  ViewProtocol.swift
//  MarvelHeroes
//
//  Created Arturo Carretero Calvo on 15/06/2020.
//  Copyright © 2020 Arturo Carretero Calvo. All rights reserved.
//

import Foundation

/// Base view interface for common tasks.
protocol ViewProtocol: class {
  
  /// Setup the UI view.
  func setupUI()
  
  /// Localized UI.
  func localizeView()
}

// MARK: - Extension with empty default implementation (to allow the protocol be optional).

extension ViewProtocol {
  
  func setupUI() {}
  func localizeView() {}
}
