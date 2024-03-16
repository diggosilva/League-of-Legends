//
//  LOLViewModel.swift
//  LeagueOfLegends
//
//  Created by Diggo Silva on 12/03/24.
//

import Foundation

enum LOLViewControllerStates {
    case loading
    case loaded
    case error
}

class LOLViewModel {
    var state: Bindable<LOLViewControllerStates> = Bindable(value: .loading)
    private var service = Service()
    
    var diggoChampions: [DiggoChampion] = []
    var roles: [String] = []
    var filters: [Filter] = []
    
    func loadDataChampions() {
        service.getChampions { diggoChampions in
            self.diggoChampions = diggoChampions
            var uniqueRoles: Set<String> = []
            
            for champion in diggoChampions {
                for role in champion.roles {
                    uniqueRoles.insert(role)
                }
            }
            self.roles = Array(uniqueRoles)
            self.roles = self.roles.sorted()
            print("Alfabeticamente: \(self.roles)")
            
            // Transforma o [String] em um [Filter]
            self.filters = self.roles.map { Filter(name: $0, isSelected: false) }
            
            self.state.value = .loaded
        } onError: { error in
            self.state.value = .error
        }
    }
}

struct Filter {
    let name: String
    var isSelected: Bool
}
