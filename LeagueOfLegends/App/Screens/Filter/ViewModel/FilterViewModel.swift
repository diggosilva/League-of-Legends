//
//  FilterViewModel.swift
//  LeagueOfLegends
//
//  Created by Diggo Silva on 15/03/24.
//

import UIKit

class FilterViewModel {
    var filters: [Filter]
    
    init(filters: [Filter]) {
        self.filters = filters
//        self.filters = self.filters.filter({ $0.name != "Tank" })
    }
    
    func numberOfRows() -> Int {
        return filters.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> Filter {
        return filters[indexPath.row]
    }
    
    func didSelectRowAt(indexPath: IndexPath) {
         filters[indexPath.row].isSelected.toggle()
    }
}
