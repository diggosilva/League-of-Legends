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
    var tags: [String] = []
    
    func loadDataChampions() {
        service.getChampions { diggoChampions in
            self.diggoChampions = diggoChampions
            var uniqueTags: Set<String> = []
            
            for champion in diggoChampions {
                for tag in champion.tags {
                    uniqueTags.insert(tag)
                }
            }
            self.tags = Array(uniqueTags)
            self.tags = self.tags.sorted()
            print("Alfabeticamente: \(self.tags)")
            
            self.state.value = .loaded
        } onError: { error in
            self.state.value = .error
        }
    }
}
