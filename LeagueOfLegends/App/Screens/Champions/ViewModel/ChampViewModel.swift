//
//  ChampViewModel.swift
//  LeagueOfLegends
//
//  Created by Diggo Silva on 12/03/24.
//

import Foundation

enum ChampViewControllerStates {
    case loading
    case loaded
    case error
}

class ChampViewModel {
    var state: Bindable<ChampViewControllerStates> = Bindable(value: .loading)
    private var service = Service()
    
    var diggoChampions: [DiggoChampion] = []
    var filters: [Filter] = []
    var roleChampionsSelected: [DiggoChampion] = []
    
    func loadDataChampions() {
        service.getChampions { diggoChampions in
            self.diggoChampions = diggoChampions
            var uniqueRoles: Set<String> = []
            
            for champion in diggoChampions {
                for role in champion.roles {
                    uniqueRoles.insert(role)
                }
            }
            let roles = Array(uniqueRoles).sorted()
            print("Alfabeticamente: \(roles)")
            
            // Transforma o [String] em um [Filter]
            self.filters = roles.map { Filter(name: $0, isSelected: false) }
            
            self.state.value = .loaded
        } onError: { error in
            self.state.value = .error
        }
    }
    
    func createRoleChampionsSelected() {
        let filtered = diggoChampions.filter { $0.roles == filters.map { $0.isSelected == true } }
    }
}
