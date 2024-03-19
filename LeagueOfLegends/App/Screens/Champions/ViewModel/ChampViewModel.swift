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
    
    var backupChampions: [DiggoChampion] = []
    var filteredChampions: [DiggoChampion] = []
    var filters: [Filter] = []
    
    func loadDataChampions() {
        service.getChampions { diggoChampions in
            self.backupChampions = diggoChampions
            self.filteredChampions = self.backupChampions
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
    
    func updateChampions(filters: [Filter]) {
        self.filters = filters
        let selectedFilters = self.filters.filter({ $0.isSelected })
        let selectedRoles = selectedFilters.map({ $0.name })
        
        self.filteredChampions = backupChampions.filter({ $0.roles.contains(selectedRoles) })
        self.state.value = .loaded
    }
    
    func numberOfRows() -> Int {
        return filteredChampions.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> DiggoChampion {
        return filteredChampions[indexPath.row]
    }
}
