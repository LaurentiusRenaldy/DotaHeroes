//
//  Hero.swift
//  DotaHeroes
//
//  Created by Renaldy on 07/10/20.
//

import Foundation

struct Hero: Equatable {
    enum AttackType: String {
        case melee = "Melee"
        case range = "Ranged"
    }
    enum PrimaryAttribute: String {
        case agility = "agi"
        case strength = "str"
        case intelligence = "int"
    }
    let fullName: String
    let avatar: String
    let type: AttackType?
    let attribute: PrimaryAttribute?
    let health: Int
    let maxAttack: Int
    let speed: Int
    let roles: [String]
}

extension Hero {
    var imageUrl: URL? {
        var components = URLComponents(string: avatar)
        components?.scheme = "https"
        components?.host = "api.opendota.com"
        return components?.url
    }
}
