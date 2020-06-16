//
//  CharacterInteractorImpl.swift
//  MarvelHeroes
//
//  Created by Arturo Carretero Calvo on 15/06/2020.
//  Copyright © 2020 Arturo Carretero Calvo. All rights reserved.
//

import UIKit

class CharacterInteractorImpl: CharacterInteractor {
    
    private let repository: CharacterRepository
    
    init(repository: CharacterRepository) {
        self.repository = repository
    }
    
    func retrieveCharacters(page: Int,
                            nameStartsWith: String?,
                            output: @escaping(_ result: CharacterResult, _ characters: [Character]?) -> Void) {
        self.repository.getAllCharacters(page: page, nameStartsWith: nameStartsWith) { (result, characters) in
            switch result {
            case .success:
                output(.success, characters)
            case .error:
                output(.error, nil)
            }
        }
    }
}
