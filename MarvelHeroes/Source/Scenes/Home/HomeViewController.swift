//
//  HomeViewController.swift
//  MarvelHeroes
//
//  Created Arturo Carretero Calvo on 15/06/2020.
//  Copyright © 2020 Arturo Carretero Calvo. All rights reserved.
//

import UIKit

/// View implementation for scene.
class HomeViewController: UIViewController {
    
    var presenter: HomePresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidUpdate(status: .didLoad)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.presenter?.viewDidUpdate(status: .didAppear)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.presenter?.viewDidUpdate(status: .didDisappear)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter?.viewDidUpdate(status: .willAppear)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.presenter?.viewDidUpdate(status: .willDisappear)
    }
}

// MARK: View interface implementation methods.
extension HomeViewController: HomeView {
    
    /// Setup the UI view.
    func setupUI() {
        if let navController = self.navigationController {
            AppStyler.styleNavigationBar(navigationController: navController)
        }
        self.centeredNavBarImage()
    }
    
    /// Localized UI.
    func localizeView() {
    }
}

// MARK: Extension for private methods.
private extension HomeViewController {
    
    func centeredNavBarImage() {
        let navcontroller = navigationController!
        let image = UIImage(named: "Marvel-comics-logo")
        let imageView = UIImageView(image:image)
        let bannerWidth = navcontroller.navigationItem.accessibilityFrame.size.width
        let bannerHeight = navcontroller.navigationBar.frame.size.height
        guard let imag = image else { return }
        let bannerX = bannerWidth / 2 - imag.size.width / 2
        let bannerY = bannerHeight / 2 - imag.size.height / 2
        imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
    }
}
