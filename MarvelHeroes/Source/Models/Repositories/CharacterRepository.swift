//
//  CharacterRepository.swift
//  MarvelHeroes
//
//  Created by Arturo Carretero Calvo on 15/06/2020.
//  Copyright © 2020 Arturo Carretero Calvo. All rights reserved.
//

import UIKit

/// Enum to know user repository operation result.
///
/// - ok: operation finished without error.
/// - error: operation finished with error.
enum CharacterRepositoryResult: Int, CaseIterable {
    
    case ok, error
}

/// Protocol to define entity handlers
protocol CharacterRepository {
}
