//
//  ShowModelViewTest.swift
//  MovieAppTests
//
//  Created by MAC on 18/08/22.
//

import XCTest
@testable import MovieApp

class ShowModelViewTest: XCTestCase {
    
    func testShowModel() throws {
        let jsonData = getTestJSONData()
        
        do {
            _ = try JSONDecoder().decode(Show.self, from: jsonData)
        }
        catch {
            XCTFail("Failed to decode JSON into the model: \(error)")
        }
    }
    
    private func getTestJSONData() -> Data {
        guard let path = Bundle.main.path(forResource: "showsData", ofType: "json") else {
            fatalError("showsData.json file not found")
        }
        let internalURL = URL(fileURLWithPath: path)
        return try! Data(contentsOf: internalURL)
    }
}
