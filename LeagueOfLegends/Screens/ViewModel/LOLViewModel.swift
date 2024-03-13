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
    
    var championsList: [ChampionResponse] = []
    var diggoChampions: [DiggoChampion] = []
    
    func numberOfRowsChampion() -> Int {
        championsList.count
    }
    
    func champion(of indexPath: IndexPath) -> ChampionResponse {
        championsList[indexPath.row]
    }
    
    func loadDataChampions() {
        service.getChampions { championRequest in
            self.championsList.append(championRequest)
        } onError: { error in
            self.state.value = .error
        } onSuccessDiggoChampions: { diggoChampions, requestWay  in
            self.diggoChampions = diggoChampions
            self.state.value = .loaded
        }
    }
}
