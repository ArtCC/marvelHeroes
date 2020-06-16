//
//  LaunchPresenter.swift
//  MarvelHeroes
//
//  Created Arturo Carretero Calvo on 15/06/2020.
//  Copyright © 2020 Arturo Carretero Calvo. All rights reserved.
//

import Foundation

/// Presenter implementation to handle abstract scene view logic.
class LaunchPresenter: Presenter {
    
    fileprivate struct Constants {
        static let launchDuration = TimeInterval(1.0)
        static let page = Int(0)
    }
    
    fileprivate weak var view: LaunchView!
    fileprivate weak var wireframe: LaunchWireframe!
    fileprivate var interactor: CharacterInteractor!
    
    init(view: LaunchView, wireframe: LaunchWireframe, interactor: CharacterInteractor) {
        self.view = view
        self.wireframe = wireframe
        self.interactor = interactor
    }
    
    func viewDidUpdate(status: ViewStatus) {
        switch status {
        case .didLoad:
            self.view.setupUI()
            self.view.localizeView()
            self.getCharacters()
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
extension LaunchPresenter {
}

// MARK: - Extension private methods.
private extension LaunchPresenter {
    
    func getCharacters() {
        self.interactor.retrieveCharacters(page: Constants.page, nameStartsWith: nil) { (result, characters) in
            self.finishLaunchScene()
        }
    }
    
    /// Finish launch scene visualization after delay.
    func finishLaunchScene() {
        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.launchDuration) {
            if let wireframe = self.wireframe {
                wireframe.presentPostLaunchScene()
            }
        }
    }
}
