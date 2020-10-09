//
//  HeroesEndpoint.swift
//  DotaHeroes
//
//  Created by Renaldy on 08/10/20.
//

import Foundation

struct HeroesEndpoint {
    let request: (@escaping (Result<Data, Error>) -> Void) -> Void
    
    init() {
        request = { completion in
            guard let url = endpoint else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            URLSession.shared.dataTask(with: request) { (data, _, error) in
                switch (data, error) {
                case (.some(let data), _): completion(.success(data))
                case (_, .some(let error)): completion(.failure(error))
                default: break
                }
            }.resume()
        }
    }
}

private let endpoint = URL(string: "https://api.opendota.com/api/herostats")
