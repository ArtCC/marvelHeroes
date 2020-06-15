//
//  LaunchWireframe.swift
//  MarvelHeroes
//
//  Created Arturo Carretero Calvo on 15/06/2020.
//  Copyright © 2020 Arturo Carretero Calvo. All rights reserved.
//

import UIKit

/// Wireframe protocol to define routing to other scenes.
protocol LaunchWireframe: class {
    
    /// Navigate to present the post launch scene.
    func presentPostLaunchScene()
}

// MARK: - UIViewController extension to implement wireframe protocol.
extension LaunchViewController: LaunchWireframe {
    
    func presentPostLaunchScene() {
        if let app = UIApplication.shared.delegate as? AppDelegate, let window = app.window {
            AppWireframe.presentPostLaunchScene(window: window)
        }
    }
    
    /// Override prepare(forsegue) method to configure next scene.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {}
}
