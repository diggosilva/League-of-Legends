//
//  Service.swift
//  LeagueOfLegends
//
//  Created by Diggo Silva on 11/03/24.
//

import Foundation

enum RequestWay {
    case unknown
    case online
    case local
}

protocol ServiceProtocol {
    var dataTask: URLSessionDataTask? { get set }
    func isUpdating() -> Bool
}

final class Service: ServiceProtocol {
    var dataTask: URLSessionDataTask?
    
    func isUpdating() -> Bool {
        if let dataTask = dataTask {
            return dataTask.state == .running
        }
        return false
    }
    
    let championsList: [String] = []
    
    func getChampions(champion: String, onSuccessDiggoChampions: @escaping([DiggoChampion], RequestWay) -> Void, onError: @escaping(Error) -> Void) {
        
        var imageURL = "https://ddragon.leagueoflegends.com/cdn/img/champion/splash/\(champion)_0.jpg"
        
        let urlRequest = URLRequest(url: URL(string: "https://ddragon.leagueoflegends.com/cdn/14.5.1/data/pt_BR/champion.json")!)
        
        dataTask = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) -> Void in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                if let response = response as? HTTPURLResponse {
                    print("DEBUG: Status Code: \(response.statusCode)")
                }
                if let data = data,
                   let response = try? JSONDecoder().decode(ChampionResponse.self, from: data) {
                    var diggoChampions: [DiggoChampion] = []
                    
                    for champion in response.data {
                        diggoChampions.append(DiggoChampion(name: champion.value.name, image: "https://ddragon.leagueoflegends.com/cdn/img/champion/splash/\(champion.value.name)_0.jpg", difficulty: champion.value.info.difficulty))
                        print(champion.value.name)
                    }
                    
                    // Dados do Servidor
                    onSuccessDiggoChampions(diggoChampions, .online)
//                    print("DEBUG: SERVERDATA aqui: \(diggoChampions)")
                } else {
                    onError(NSError(domain: "DEBUG: Erro ao decodificar os dados Mockados.", code: 1))
                }
            }
        })
        dataTask?.resume()
    }
    
    
//    func getChampions(onSuccessDiggoChampions: @escaping([DiggoChampion], RequestWay) -> Void, onError: @escaping(Error) -> Void) {
//        let headers = [
//            "X-RapidAPI-Key": "d9c20cdbd1msh04b90ccfabbe987p1dee69jsna0ec5145b3b7",
//            "X-RapidAPI-Host": "league-of-legends-champions.p.rapidapi.com"
//        ]
//        
//        let url = URL(string: "https://league-of-legends-champions.p.rapidapi.com/champions/pt-br?page=0&size=10")!
//        var urlRequest = URLRequest(url: url)
//        urlRequest.httpMethod = "GET"
//        urlRequest.allHTTPHeaderFields = headers
//        
//        dataTask = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) -> Void in
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                if let response = response as? HTTPURLResponse {
//                    print("DEBUG: Status Code: \(response.statusCode)")
//                }
//                if let data = data,
//                   let response = try? JSONDecoder().decode(ChampionResponse.self, from: data) {
//                    var diggoChampions: [DiggoChampion] = []
//                    
//                    for champion in response.data {
//                        diggoChampions.append(DiggoChampion(name: champion.value.name, image: champion.value.image.full, difficulty: champion.value.info.difficulty))
//                    }
//                    
//                    // Dados do Servidor
//                    onSuccessDiggoChampions(diggoChampions, .online)
////                    print("DEBUG: SERVERDATA aqui: \(diggoChampions)")
//                } else if let path = Bundle.main.path(forResource: "champions", ofType: "json"),
//                          let data = try? Data(contentsOf: URL(filePath: path)),
//                          let response = try? JSONDecoder().decode(ChampionResponse.self, from: data) {
//                    var diggoChampions: [DiggoChampion] = []
//                    
//                    for champion in response.data {
//                        diggoChampions.append(DiggoChampion(name: champion.value.name, image: champion.value.image.full, difficulty: champion.value.info.difficulty))
//                    }
//                    
//                    // Dados Locais
//                    onSuccessDiggoChampions(diggoChampions, .local)
////                    print("DEBUG: MOCKDATA aqui: \(diggoChampions)")
//                } else {
//                    onError(NSError(domain: "DEBUG: Erro ao decodificar os dados Mockados.", code: 1))
//                }
//            }
//        })
//        dataTask?.resume()
//    }
}
