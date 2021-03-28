//
//  DetailConfigurator.swift
//  MarvelHeroes
//
//  Created Arturo Carretero Calvo on 15/06/2020.
//  Copyright © 2020 Arturo Carretero Calvo. All rights reserved.
//

import UIKit

/// Configurator class to provide a complete scene ready to use.
class DetailConfigurator: Configurator {

  static let shared = DetailConfigurator()

  /// Class constants.
  fileprivate struct Constants {
    static let storyboardName: String = "Main"
    static let storyboardId: String = "DetailViewController"
  }

  func isValid(viewController: UIViewController) -> Bool {
    return viewController is DetailViewController
  }

  func storyboardName() -> String {
    return Constants.storyboardName
  }

  func storyboardId() -> String {
    return Constants.storyboardId
  }

  func prepareScene(viewController: UIViewController) {
    let presenter = DetailPresenter(view: viewController as! DetailView,
                                    wireframe: viewController as! DetailWireframe)
    guard let viewController = viewController as? DetailViewController else {
      assertionFailure("Invalid UIViewController to prepare scene")
      return
    }
    viewController.presenter = presenter
  }
}
