//
//  DetailPresenter.swift
//  MarvelHeroes
//
//  Created Arturo Carretero Calvo on 15/06/2020.
//  Copyright © 2020 Arturo Carretero Calvo. All rights reserved.
//

import Foundation

/// Presenter implementation to handle abstract scene view logic.
class DetailPresenter: Presenter {
    
    fileprivate struct Constants {
        static let duration = TimeInterval(1.5)
    }
    
    var character: Character?
    
    fileprivate weak var view: DetailView!
    fileprivate weak var wireframe: DetailWireframe!
    
    init(view: DetailView, wireframe: DetailWireframe) {
        self.view = view
        self.wireframe = wireframe
    }
    
    func viewDidUpdate(status: ViewStatus) {
        switch status {
        case .didLoad:
            self.view.setupUI()
            self.view.localizeView()
            self.getCharacter()
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
extension DetailPresenter {
}

// MARK: - Extension private methods.
private extension DetailPresenter {
    
    func getCharacter() {
        guard let character = self.character else { return }
        self.view.show(character: character)
    }
}
