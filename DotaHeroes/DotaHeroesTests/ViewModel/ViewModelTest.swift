//
//  ViewModelTest.swift
//  DotaHeroesTests
//
//  Created by Renaldy on 08/10/20.
//

import XCTest
import Combine

@testable import DotaHeroes

class ViewModelTest: XCTestCase {
    
    func testLoad() {
        let viewModel = ViewModel(
            getHeroes: { Future<[Hero], Error> { $0(.success([.sample1, .sample2])) } }
        )
        var heroes = [Hero]()
        let heroesExpectation = self.expectation(description: "expecting heroes")
        heroesExpectation.expectedFulfillmentCount = 2
        
        var roles = [String]()
        let rolesExpectation = self.expectation(description: "expecting roles")
        rolesExpectation.expectedFulfillmentCount = 2
        
        let heroesCancellable = viewModel.$heroes.sink {
            heroes = $0
            heroesExpectation.fulfill()
        }
        let rolesCancellable = viewModel.$roles.sink {
            roles = Array($0).sorted()
            rolesExpectation.fulfill()
        }
        
        defer {
            heroesCancellable.cancel()
            rolesCancellable.cancel()
        }
        
        viewModel.load()
        
        waitForExpectations(timeout: 1, handler: nil)
        
        XCTAssertTrue(heroes.count == 2)
        XCTAssertEqual(heroes.map { $0.fullName }, ["sample 1", "sample 2"])
        XCTAssertEqual(roles, ["roleA", "roleB", "roleC", "roleD"])
    }
    
}

private extension Hero {
    static var sample1: Hero {
        .init(fullName: "sample 1", avatar: "",
              type: .melee, attribute: .agility,
              health: 1, maxAttack: 1, speed: 1,
              roles: ["roleA", "roleB", "roleC"])
    }
    
    static var sample2: Hero {
        .init(fullName: "sample 2", avatar: "",
              type: .melee, attribute: .agility,
              health: 1, maxAttack: 1, speed: 1,
              roles: ["roleB", "roleC", "roleD"])
    }
}
