//
//  HomePresenter.swift
//  MarvelHeroes
//
//  Created Arturo Carretero Calvo on 15/06/2020.
//  Copyright © 2020 Arturo Carretero Calvo. All rights reserved.
//

import Foundation

/// Presenter implementation to handle abstract scene view logic.
class HomePresenter: Presenter {
    
    fileprivate struct Constants {
        static let duration = TimeInterval(1.5)
    }
    
    fileprivate weak var view: HomeView!
    fileprivate weak var wireframe: HomeWireframe!
    
    init(view: HomeView, wireframe: HomeWireframe) {
        self.view = view
        self.wireframe = wireframe
    }
    
    func viewDidUpdate(status: ViewStatus) {
        switch status {
        case .didLoad:
            self.view.setupUI()
            self.view.localizeView()
        case .didAppear:
            break
        case .didDisappear:
            break
        case .willAppear:
            break
        case .willDisappear:
            break
        }
    }
}

// MARK: - Presenter public custom methods to handle view events.
extension HomePresenter {
}

// MARK: - Extension private methods.
private extension HomePresenter {
}
