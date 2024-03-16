//
//  FilterViewModel.swift
//  LeagueOfLegends
//
//  Created by Diggo Silva on 15/03/24.
//

import UIKit

class FilterViewModel {
    var service = Service()
    
    var diggoChampions: [DiggoChampion] = []
    var roles: [String]
    
    init(roles: [String]) {
        self.roles = roles
    }
    
//    func loadDataChampions() {
//        service.getChampions { diggoChampions in
//            self.diggoChampions = diggoChampions
//            var uniqueRoles: Set<String> = []
//            
//            for champion in diggoChampions {
//                for role in champion.roles {
//                    uniqueRoles.insert(role)
//                }
//            }
//            self.roles = Array(uniqueRoles)
//            self.roles = self.roles.sorted()
//            print("FILTER: \(self.roles)")
//        } onError: { error in
//            
//        }
//    }
}
