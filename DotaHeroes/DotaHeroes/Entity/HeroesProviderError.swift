//
//  HeroesProviderError.swift
//  DotaHeroes
//
//  Created by Renaldy on 08/10/20.
//

import Foundation

enum HeroesProviderError: Error {
    case failToDecode
    case unhandled(Error)
}

extension HeroesProviderError: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case (.failToDecode, .failToDecode): return true
        case (.unhandled, .unhandled): return true
        default: return false
        }
    }
}
