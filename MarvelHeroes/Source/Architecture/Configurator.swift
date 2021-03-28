//
//  Configurator.swift
//  MarvelHeroes
//
//  Created Arturo Carretero Calvo on 15/06/2020.
//  Copyright © 2020 Arturo Carretero Calvo. All rights reserved.
//

import UIKit

/// Base class to perform base behaviour for the app scene configurators.
protocol Configurator {
  
  /// Retrieve a fresh view controller for the scene to configure.
  ///
  /// - Returns: a valid view controller for the current scene.
  func rawViewController() -> UIViewController?
  
  /// Retrieve a configured view controller for the scene.
  ///
  /// - Returns: a valid view controller for the current scene ready to use.
  func preparedViewController() -> UIViewController?
  
  /// Prepare scene (handle input params and resolve dependencies) to use it.
  func prepareScene(viewController: UIViewController)
  
  /// Setup input params and delegate for the new scene.
  ///
  /// - Parameters:
  ///   - inputParams: optional input params for the new scene.
  ///   - delegate: optional delegate for the new scene.
  ///   - viewController: scene view controller.
  func setup(inputParams: Any?, delegate: Any?, forViewController viewController: UIViewController)
  
  /// Retrieve the storyboard name related with the scene UI.
  ///
  /// - Returns: a valid storyboard name.
  func storyboardName() -> String
  
  /// Retrieve the storyboard identifier related with the scene UI.
  ///
  /// - Returns: a valid storyboard identifier.
  func storyboardId() -> String
  
  /// Check if the view controller is valid for the current scene.
  ///
  /// - Parameter viewController: view controller to check.
  /// - Returns: true if the view controller is valid.
  func isValid(viewController: UIViewController) -> Bool
}

// MARK: - Protocol extension to provide a default implementation for some methods.

extension Configurator {
  
  func rawViewController() -> UIViewController? {
    let storyboard = UIStoryboard(name: storyboardName(), bundle: nil)
    let viewController = storyboard.instantiateViewController(withIdentifier: storyboardId())
    if !isValid(viewController: viewController) {
      assertionFailure("Invalid UIViewController to prepare scene")
      return nil
    }
    return viewController
  }
  
  func preparedViewController() -> UIViewController? {
    guard let viewController = rawViewController() else { return nil }
    prepareScene(viewController: viewController)
    return viewController
  }
  
  func setup(inputParams: Any?, delegate: Any?, forViewController viewController: UIViewController) {}
}
