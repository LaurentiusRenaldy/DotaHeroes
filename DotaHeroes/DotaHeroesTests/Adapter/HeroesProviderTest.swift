//
//  HeroesProviderTest.swift
//  DotaHeroesTests
//
//  Created by Renaldy on 08/10/20.
//

import XCTest

@testable import DotaHeroes

class HeroesProviderTest: XCTestCase {

    func testGet() throws {
        let jsonData = loadFile(named: "sample_response", fileType: .json)
        let provider = HeroesProvider(
            request: { completion in completion(.success(jsonData)) }
        )
        
        var result: Result<[Hero], Error>?
        provider.get() { result = $0 }
        
        let heroes = try XCTUnwrap(result?.get())
        let expectedHeroes: [Hero] = [
            .init(fullName: "Anti-Mage", avatar: "/apps/dota2/images/heroes/antimage_full.png?",
                  type: .melee, attribute: .agility,
                  health: 200, maxAttack: 33,
                  speed: 310, roles: ["Carry", "Escape", "Nuker"]),
            .init(fullName: "Axe", avatar: "/apps/dota2/images/heroes/axe_full.png?",
                  type: .melee, attribute: .strength,
                  health: 200, maxAttack: 31,
                  speed: 310, roles: ["Initiator", "Durable", "Disabler", "Jungler"]),
            .init(fullName: "Bane", avatar: "/apps/dota2/images/heroes/bane_full.png?",
                  type: .range, attribute: .intelligence,
                  health: 200, maxAttack: 41,
                  speed: 305, roles: ["Support", "Disabler", "Nuker", "Durable"])
        ]
        
        XCTAssertEqual(heroes, expectedHeroes)
    }

    func testGetFailBecauseInvalidResponse() {
        let anyData = Data()
        let provider = HeroesProvider(
            request: { completion in completion(.success(anyData)) }
        )
        
        var result: Result<[Hero], Error>?
        provider.get() { result = $0 }
        
        XCTAssertThrowsError(try result?.get()) { error in
            XCTAssertEqual(error as? HeroesProviderError, .failToDecode)
        }
    }
    
    func testGetFailBecauseRequestError() {
        let provider = HeroesProvider (
            request: { completion in completion(.failure(ErrorInTest.sample)) }
        )
        
        var result: Result<[Hero], Error>?
        provider.get() { result = $0 }
        
        XCTAssertThrowsError(try result?.get()) { error in
            XCTAssertEqual(error as? HeroesProviderError, .unhandled(ErrorInTest.sample))
        }
    }
}

private enum ErrorInTest: Error {
    case sample
}

private enum FileType: String {
    case json
}

private extension XCTest {
    func loadFile(named: String, fileType: FileType) -> Data {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: named, ofType: fileType.rawValue)
        let nsData = NSData(contentsOfFile: path!)
        return Data(referencing: nsData!)
    }
}
