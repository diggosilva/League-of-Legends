//
//  Response.swift
//  LeagueOfLegends
//
//  Created by Diggo Silva on 12/03/24.
//

import Foundation

//// MARK: - ChampionResponse
//struct ChampionResponse: Codable {
//    let champions: [DiggoChampion]
//    
//    // MARK: - Champion
//    struct DiggoChampion: Codable {
//        let node: Node
//    }
//    
//    // MARK: - Node
//    struct Node: Codable {
//        let championName: String
//        let championSplash: String
//        let difficulty: Int
//        
//        enum CodingKeys: String, CodingKey {
//            case championName = "champion_name"
//            case championSplash = "champion_splash"
//            case difficulty
//        }
//    }
//}


// MARK: - ChampionResponse
struct ChampionResponse: Codable {
    let type: TypeEnum
    let format: String
    let version: Version
    let data: [String: Datum]
    
    // MARK: - Datum
    struct Datum: Codable {
        let version: Version
        let name: String
        let info: Info
        let image: Image
    }

    // MARK: - Image
    struct Image: Codable {
        let full: String
        let sprite: Sprite
        let group: TypeEnum
        let x, y, w, h: Int
    }

    enum TypeEnum: String, Codable {
        case champion = "champion"
    }

    enum Sprite: String, Codable {
        case champion0PNG = "champion0.png"
        case champion1PNG = "champion1.png"
        case champion2PNG = "champion2.png"
        case champion3PNG = "champion3.png"
        case champion4PNG = "champion4.png"
        case champion5PNG = "champion5.png"
    }

    // MARK: - Info
    struct Info: Codable {
        let difficulty: Int
    }

    enum Version: String, Codable {
        case the1451 = "14.5.1"
    }
}
