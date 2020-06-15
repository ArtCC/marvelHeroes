//
//  LaunchConfigurator.swift
//  MarvelHeroes
//
//  Created Arturo Carretero Calvo on 15/06/2020.
//  Copyright © 2020 Arturo Carretero Calvo. All rights reserved.
//

import UIKit

/// Configurator class to provide a complete scene ready to use.
class LaunchConfigurator: Configurator {
    
    static let shared = LaunchConfigurator()
    
    /// Class constants.
    fileprivate struct Constants {
        static let storyboardName: String = "Main"
        static let storyboardId: String = "LaunchViewController"
    }
    
    func isValid(viewController: UIViewController) -> Bool {
        return viewController is LaunchViewController
    }
    
    func storyboardName() -> String {
        return Constants.storyboardName
    }
    
    func storyboardId() -> String {
        return Constants.storyboardId
    }
    
    func prepareScene(viewController: UIViewController) {
        let presenter = LaunchPresenter(view: viewController as! LaunchView,
                                        wireframe: viewController as! LaunchWireframe)
        guard let viewController = viewController as? LaunchViewController else {
            assertionFailure("Invalid UIViewController to prepare scene")
            return
        }
        viewController.presenter = presenter
    }
}
