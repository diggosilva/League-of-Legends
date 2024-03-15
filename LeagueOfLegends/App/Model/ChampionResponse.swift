//
//  Response.swift
//  LeagueOfLegends
//
//  Created by Diggo Silva on 12/03/24.
//

import Foundation

// MARK: - ChampionResponse
struct ChampionResponse: Codable {
    let format: String
    let version: Version
    let data: [String: Datum]
    
    // MARK: - Datum
    struct Datum: Codable {
        let version: Version
        let name: String
        let info: Info
        let image: Image
        let tags: [String]
    }
    
    // MARK: - Image
    struct Image: Codable {
        let full: String
    }
    
    // MARK: - Info
    struct Info: Codable {
        let difficulty: Int
    }
    
    enum Tag: String, Codable {
        case assassin = "Assassin"
        case fighter = "Fighter"
        case mage = "Mage"
        case marksman = "Marksman"
        case support = "Support"
        case tank = "Tank"
    }
    
    enum Version: String, Codable {
        case the1451 = "14.5.1"
    }
}
