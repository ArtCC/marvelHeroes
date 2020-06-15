//
//  HomeConfigurator.swift
//  MarvelHeroes
//
//  Created Arturo Carretero Calvo on 15/06/2020.
//  Copyright © 2020 Arturo Carretero Calvo. All rights reserved.
//

import UIKit

/// Configurator class to provide a complete scene ready to use.
class HomeConfigurator: Configurator {
    
    static let shared = HomeConfigurator()
    
    /// Class constants.
    fileprivate struct Constants {
        static let storyboardName: String = "Main"
        static let storyboardId: String = "HomeViewController"
    }
    
    func isValid(viewController: UIViewController) -> Bool {
        return viewController is HomeViewController
    }
    
    func storyboardName() -> String {
        return Constants.storyboardName
    }
    
    func storyboardId() -> String {
        return Constants.storyboardId
    }
    
    func prepareScene(viewController: UIViewController) {
        let presenter = HomePresenter(view: viewController as! HomeView,
                                      wireframe: viewController as! HomeWireframe)
        guard let viewController = viewController as? HomeViewController else {
            assertionFailure("Invalid UIViewController to prepare scene")
            return
        }
        viewController.presenter = presenter
    }
}
