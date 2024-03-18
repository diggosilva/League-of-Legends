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
    var roles: [Filter]
    
    init(roles: [Filter]) {
        self.roles = roles
    }
    
    func numberOfRows() -> Int {
        roles.count
    }
}
