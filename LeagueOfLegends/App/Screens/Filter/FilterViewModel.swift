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
    var tags: [String]
    
    init(tags: [String]) {
        self.tags = tags
    }
    
//    func loadDataChampions() {
//        service.getChampions { diggoChampions in
//            self.diggoChampions = diggoChampions
//            var uniqueTags: Set<String> = []
//            
//            for champion in diggoChampions {
//                for tag in champion.tags {
//                    uniqueTags.insert(tag)
//                }
//            }
//            self.tags = Array(uniqueTags)
//            self.tags = self.tags.sorted()
//            print("FILTER: \(self.tags)")
//        } onError: { error in
//            
//        }
//    }
}
