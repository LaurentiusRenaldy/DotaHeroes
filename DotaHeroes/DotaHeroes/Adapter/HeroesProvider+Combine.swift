//
//  HeroesProvider+Combine.swift
//  DotaHeroes
//
//  Created by Renaldy on 08/10/20.
//

import Foundation
import Combine

extension HeroesProvider {
    func futureHeroes() -> Future<[Hero], Error> {
        Future<[Hero], Error> { promise in
            get() { result in
                switch result {
                case .success(let items): promise(.success(items))
                case .failure(let error): promise(.failure(error))
                }
            }
        }
    }
}
