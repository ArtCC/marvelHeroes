//
//  AppWireframe.swift
//  MarvelHeroes
//
//  Created by Arturo Carretero Calvo on 15/06/2020.
//  Copyright © 2020 Arturo Carretero Calvo. All rights reserved.
//

import UIKit

class AppWireframe {
  
  fileprivate struct Constants {
    static let appTransitionAnimationDuration = TimeInterval(0.3)
    static let appTransitionScaleAnimation = CGFloat(1.5)
  }
  
  /// Method to prepare and present the initial scene for the app.
  ///
  /// - Parameter window: app main window.
  class func presentInitialScene(window: UIWindow) {
    window.rootViewController = LaunchConfigurator.shared.preparedViewController()
  }
  
  /// Method to prepare and present the main post launch scene.
  ///
  /// - Parameter window: app main window.
  class func presentPostLaunchScene(window: UIWindow) {
    self.presentHomeScene(window: window)
  }
}

// MARK: - AppWireframe private methods.

private extension AppWireframe {
  
  /// Present home scene
  /// - Parameter window: UIWindow
  class func presentHomeScene(window: UIWindow) {
    guard let homeViewController = HomeConfigurator.shared.preparedViewController() else { return }
    let navigationController = UINavigationController(rootViewController: homeViewController)
    presentNewRoot(viewController: navigationController, window: window, scaling: true)
  }
  
  /// Present with animation the new root view controller in main app window.
  ///
  /// - Parameters:
  ///   - viewController: new view controller to present.
  ///   - window: app current main window.
  class func presentNewRoot(viewController: UIViewController, window: UIWindow, scaling: Bool) {
    if let snapshot = window.snapshotView(afterScreenUpdates: true) {
      viewController.view.addSubview(snapshot)
      window.rootViewController = viewController
      UIView.animate(withDuration: AppWireframe.Constants.appTransitionAnimationDuration,
                     animations: {
                      snapshot.layer.opacity = Float(0.0)
                      if scaling {
                        snapshot.layer.transform = CATransform3DMakeScale(AppWireframe.Constants.appTransitionScaleAnimation,
                                                                          AppWireframe.Constants.appTransitionScaleAnimation,
                                                                          AppWireframe.Constants.appTransitionScaleAnimation)
                      }
                     }, completion: { (finished) in
                      snapshot.removeFromSuperview()
                     })
    }
  }
}
