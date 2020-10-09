//
//  HeroResponse.swift
//  DotaHeroes
//
//  Created by Renaldy on 08/10/20.
//

import Foundation

struct HeroResponse: Decodable {
    let localizedName: String
    let img: String
    let attackType: String
    let primaryAttr: String
    let baseHealth: Int
    let baseAttackMax: Int
    let moveSpeed: Int
    let roles: [String]
}

extension HeroResponse {
    static func decode(from data: Data) throws -> [HeroResponse] {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return try jsonDecoder.decode([HeroResponse].self, from: data)
    }
}

extension Hero {
    init(from response: HeroResponse) {
        fullName = response.localizedName
        avatar = response.img
        type = Hero.AttackType(rawValue: response.attackType)
        attribute = Hero.PrimaryAttribute(rawValue: response.primaryAttr)
        health = response.baseHealth
        maxAttack = response.baseAttackMax
        speed = response.moveSpeed
        roles = response.roles
    }
}
