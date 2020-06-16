//
//  CharacterRepositoryImpl.swift
//  MarvelHeroes
//
//  Created by Arturo Carretero Calvo on 15/06/2020.
//  Copyright © 2020 Arturo Carretero Calvo. All rights reserved.
//

import UIKit
import Alamofire

class CharacterRepositoryImpl: CharacterRepository {
    
    func getAllCharacters(page: Int,
                          nameStartsWith: String?,
                          output: @escaping(_ result: CharacterResult, _ characters: [Character]?) -> Void) {
        let ts = String(Date().timeIntervalSince1970)
        var urlParams = [
            "ts" : ts,
            "hash" : MD5.MD5Hex(data: MD5.MD5(string: ts + Constants.privateKey + Constants.publicKey)).lowercased(),
            "apikey" : Constants.publicKey,
            "limit" : String(Constants.limit),
            "offset" : String(page * Constants.limit)
        ]
        if let name = nameStartsWith {
            urlParams.updateValue(name, forKey: "nameStartsWith")
        }
        AF.request(Constants.basePath + Constants.charactersPath, method: .get, parameters: urlParams)
            .validate(statusCode: 200..<300)
            .validate(contentType: [Constants.application])
            .responseJSON { (response) in
                printDebug(String(describing: response))
                switch response.result {
                case .success:
                    self.getCharactersFromResponse(dataResponse: response.data) { (characters) in
                        SessionManager.shared.characters = characters
                        output(.success, characters)
                    }
                case let .failure(error):
                    printDebug("CharacterRepositoryImpl:getAllCharacters:error: \(error.localizedDescription)")
                    output(.error, nil)
                }
        }
    }
}

private extension CharacterRepositoryImpl {
    
    /// Get all characters from data response
    /// - Parameters:
    ///   - dataResponse: data object
    ///   - output: array with object models
    func getCharactersFromResponse(dataResponse: Data?,
                                   output: @escaping(_ characters: [Character]?) -> Void) {
        guard let dataResponse = dataResponse else { return output(nil) }
        let json = try? JSONSerialization.jsonObject(with: dataResponse, options: [])
        guard let data: [String : Any] = json as? [String : Any],
            let dataDict: [String : Any] = data[Constants.data] as? [String : Any],
            let resultsArray: [[String : Any]] = dataDict[Constants.results] as? [[String : Any]] else {
                return output(nil)
        }
        var characters: [Character] = []
        for character in resultsArray {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: character,
                                                          options: .prettyPrinted)
                let cha = try JSONDecoder().decode(Character.self, from: jsonData)
                characters.append(cha)
            } catch ( let error ) {
                printDebug(error.localizedDescription)
            }
        }
        output(characters)
    }
}
