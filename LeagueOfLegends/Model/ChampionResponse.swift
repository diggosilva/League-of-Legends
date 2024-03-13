//
//  Response.swift
//  LeagueOfLegends
//
//  Created by Diggo Silva on 12/03/24.
//

import Foundation

// MARK: - ChampionResponse
struct ChampionResponse: Codable {
    let champions: [DiggoChampion]
    
    // MARK: - Champion
    struct DiggoChampion: Codable {
        let node: Node
    }
    
    // MARK: - Node
    struct Node: Codable {
        let championName: String
        let championSplash: String
        
        enum CodingKeys: String, CodingKey {
            case championName = "champion_name"
            case championSplash = "champion_splash"
        }
    }
}
