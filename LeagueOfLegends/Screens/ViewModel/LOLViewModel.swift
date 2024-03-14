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
    
    func loadDataChampions() {
        service.getChampions { diggoChampions, requestWay in
            self.diggoChampions = diggoChampions
            self.state.value = .loaded
        } onError: { error in
            self.state.value = .error
        }
    }
}
