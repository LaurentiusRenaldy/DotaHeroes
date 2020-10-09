//
//  ViewModel.swift
//  DotaHeroes
//
//  Created by Renaldy on 07/10/20.
//

import Foundation
import Combine

final class ViewModel {
    @Published private(set) var heroes = [Hero]()
    @Published private(set) var roles = Set<String>() {
        didSet {
            filter(role: Array(roles).sorted().first)
        }
    }
    private var defaultHeroes = [Hero]()
    
    typealias GetHeroes = () -> Future<[Hero], Error>
    private let getHeroes: GetHeroes
    
    private var loadCancellables: AnyCancellable?
    
    init(getHeroes: @escaping GetHeroes) {
        self.getHeroes = getHeroes
    }
    
    func load() {
        loadCancellables = getHeroes()
            .sink(receiveCompletion: { _ in },
                  receiveValue: onReceive(heroes:))
    }
    
    func filter(role: String?) {
        guard let safeRole = role else { return }
        heroes = defaultHeroes.filter { $0.roles.contains { $0.contains(safeRole) } }
    }
    
    private func onReceive(heroes: [Hero]) {
        self.defaultHeroes = heroes
        roles = Set(heroes.flatMap { $0.roles.map { $0 } })
    }
}

extension ViewModel {
    static func create() -> ViewModel {
        let provider = HeroesProvider.create()
        return ViewModel(getHeroes: provider.futureHeroes)
    }
}
