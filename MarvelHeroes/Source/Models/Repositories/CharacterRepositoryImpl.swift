//
//  CharacterRepositoryImpl.swift
//  MarvelHeroes
//
//  Created by Arturo Carretero Calvo on 15/06/2020.
//  Copyright © 2020 Arturo Carretero Calvo. All rights reserved.
//

import UIKit

class CharacterRepositoryImpl: CharacterRepository {
    
    fileprivate struct Constants {
        
        static let basePath = "https://gateway.marvel.com/v1/public/characters?"
        static let privateKey = "a68a7e61345d6a714370727b3dde8e44a4b27ea2"
        static let publicKey = "4002ee1976a96a15c89cce80085ae2e0"
        static let limit = 50
    }
}

private extension CharacterRepositoryImpl {
    
    /// Get parameters for general request
    /// - Returns: timestamp, apikey and hash (timestamp + private key + public key in MD5 hash)
    func getCredentials() -> String {
        let ts = String(Date().timeIntervalSince1970)
        let hash = MD5.MD5Hex(data: MD5.MD5(string: ts + Constants.privateKey + Constants.publicKey)).lowercased()
        return "&ts=\(ts)&apikey=\(Constants.publicKey)&hash=\(hash)"
    }
}
