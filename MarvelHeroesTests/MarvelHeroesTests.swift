//
//  MarvelHeroesTests.swift
//  MarvelHeroesTests
//
//  Created by Arturo Carretero Calvo on 15/06/2020.
//  Copyright © 2020 Arturo Carretero Calvo. All rights reserved.
//

import XCTest
@testable import MarvelHeroes

class MarvelHeroesTests: XCTestCase {
    
    var sut: URLSession!
    
    override func setUp() {
        super.setUp()
        sut = URLSession(configuration: .default)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    /// Asynchronous test for Marvel API
    func testValidCallToMarvelAPIGetsHTTPStatusCode200() {
        let ts = String(Date().timeIntervalSince1970)
        let hash = MD5.MD5Hex(data: MD5.MD5(string: ts + Constants.privateKey + Constants.publicKey)).lowercased()
        let urlParams = "ts=" + ts + "&hash=" + hash + "&apikey=" + Constants.publicKey + "&limit=50&offset=0"
        let url = URL(string: Constants.basePath + Constants.charactersPath + urlParams)
        let promise = expectation(description: "Status code: 200")
        let dataTask = sut.dataTask(with: url!) { data, response, error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5)
    }
    
    /// Asynchronous test for Marvel API and create character object with responso
    func testValidCallToMarvelAPIGetOneResultAndCreateCharacter() {
        let ts = String(Date().timeIntervalSince1970)
        let hash = MD5.MD5Hex(data: MD5.MD5(string: ts + Constants.privateKey + Constants.publicKey)).lowercased()
        let urlParams = "ts=" + ts + "&hash=" + hash + "&apikey=" + Constants.publicKey + "&limit=1&offset=0&nameStartsWith=spider"
        let url = URL(string: Constants.basePath + Constants.charactersPath + urlParams)
        let promise = expectation(description: "Create character object")
        let dataTask = sut.dataTask(with: url!) { data, response, error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    guard let data = data, error == nil else { return }
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String : Any]
                        guard let dataDict: [String : Any] = json[Constants.data] as? [String : Any],
                            let resultsArray: [[String : Any]] = dataDict[Constants.results] as? [[String : Any]] else {
                                return XCTFail("Error in JSON parser")
                        }
                        for character in resultsArray {
                            do {
                                let jsonData = try JSONSerialization.data(withJSONObject: character,
                                                                          options: .prettyPrinted)
                                let cha = try JSONDecoder().decode(Character.self, from: jsonData)
                                printDebug(String(describing: cha))
                                promise.fulfill()
                            } catch ( let error ) {
                                XCTFail("Error in JSON parser: \(error.localizedDescription)")
                            }
                        }
                    } catch let error as NSError {
                        XCTFail("Error: \(error.localizedDescription)")
                    }
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5)
    }
}
