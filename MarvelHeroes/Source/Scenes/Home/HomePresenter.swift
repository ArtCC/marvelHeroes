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
    fileprivate var interactor: CharacterInteractor!
    fileprivate var page = Int(0)
    
    init(view: HomeView, wireframe: HomeWireframe, interactor: CharacterInteractor) {
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
    
    func select(character: Character) {
        self.wireframe.navigateToDetailScene(character: character)
    }
    
    func getMoreCharactersWithPagination() {
        self.page += 1
        self.interactor.retrieveCharacters(page: self.page, nameStartsWith: nil) { (result, characters) in
            if let collection = characters {
                self.view.addNewCharacters(characters: collection)
            }
        }
    }
    
    func searchCustom(string: String) {
        self.interactor.retrieveCharacters(page: 0, nameStartsWith: string) { (result, characters) in
            guard let characters = SessionManager.shared.characters else { return}
            self.view.showCharactersFromSearch(characters: characters)
        }
    }
    
    func reloadOriginalData() {
        self.interactor.retrieveCharacters(page: 0, nameStartsWith: nil) { (result, characters) in
            guard let characters = SessionManager.shared.characters else { return}
            self.view.show(characters: characters)
        }
    }
}

// MARK: - Presenter public custom methods to handle view events.
extension HomePresenter {
}

// MARK: - Extension private methods.
private extension HomePresenter {
    
    func getCharacters() {
        guard let characters = SessionManager.shared.characters else { return self.view.empty()}
        self.view.show(characters: characters)
    }
}
