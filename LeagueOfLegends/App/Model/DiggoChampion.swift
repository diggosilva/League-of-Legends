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
    let roles: [String]
    
    var colorDifficulty: UIColor {
        if difficulty > 5 {
            return UIColor.systemRed
        }
        return UIColor.systemGreen
    }
    
    var imageUrl: URL? {
        let nameChamp = name.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "'", with: "")
        return URL(string: "https://ddragon.leagueoflegends.com/cdn/img/champion/splash/\(nameChamp)_0.jpg")
    }
}
