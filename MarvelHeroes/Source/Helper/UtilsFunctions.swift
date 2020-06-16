//
//  UtilsFunctions.swift
//  MarvelHeroes
//
//  Created by Arturo Carretero Calvo on 15/06/2020.
//  Copyright © 2020 Arturo Carretero Calvo. All rights reserved.
//

import UIKit

public func printDebug(_ items: String) {
    
    if UtilsFunctions.checkIfDEBUG() {
        print(items)
    }
}

class UtilsFunctions: NSObject {
    
    /// Function for check is app in debuf or not
    ///
    /// - Returns: Bool value
    static func checkIfDEBUG() -> Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
}
