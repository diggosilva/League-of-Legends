//
//  DiggoChampion.swift
//  LeagueOfLegends
//
//  Created by Diggo Silva on 13/03/24.
//

import UIKit

// MARK: - ChampionResponse
struct DiggoChampion: Codable {
    let name: String
    let image: String
    let difficulty: Int
    
    var colorDifficulty: UIColor {
        if difficulty > 5 {
            return UIColor.systemRed
        }
        return UIColor.systemGreen
    }
}
