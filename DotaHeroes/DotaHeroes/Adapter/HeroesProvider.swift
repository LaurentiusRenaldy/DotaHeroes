//
//  HeroesProvider.swift
//  DotaHeroes
//
//  Created by Renaldy on 08/10/20.
//

import Foundation

struct HeroesProvider {
    typealias APIRequest = (@escaping (APIResult) -> Void) -> Void
    typealias APIResult = Result<Data, Error>
    typealias CompletionBlock = (Result<[Hero], Error>) -> Void
    
    let request: APIRequest
    
    func get(onCompleted: @escaping CompletionBlock) {
        func handleSuccess(_ data: Data, _ completion: CompletionBlock) {
            do {
                let response = try HeroResponse.decode(from: data)
                completion(.success(response.map(Hero.init(from:))))
            } catch {
                completion(.failure(HeroesProviderError.failToDecode))
            }
        }

        request() { result in
            switch result {
            case .success(let data): handleSuccess(data, onCompleted)
            case .failure(let error): onCompleted(.failure(HeroesProviderError.unhandled(error)))
            }
        }
    }
}

extension HeroesProvider {
    static func create() -> Self {
        return HeroesProvider(request: HeroesEndpoint().request)
    }
}
