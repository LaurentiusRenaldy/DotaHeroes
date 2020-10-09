//
//  HeroesEndpointTest.swift
//  DotaHeroesTests
//
//  Created by Renaldy on 08/10/20.
//

import XCTest

@testable import DotaHeroes

class HeroesEndpointTest: XCTestCase {

    func testGetTrendingRepo() {
        let expectation = self.expectation(description: "Get Trending Repo")
        var result: Result<Data, Error>?
        
        HeroesEndpoint().request() { result = $0; expectation.fulfill() }
        waitForExpectations(timeout: 10, handler: nil)
        
        XCTAssertTrue(try XCTUnwrap(result?.get().toString()).contains("name"))
    }

}


private extension Data {
    func toString() -> String? {
        String(data: self, encoding: .utf8)
    }
}
