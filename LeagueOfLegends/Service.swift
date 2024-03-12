//
//  Service.swift
//  LOL
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
    
    func getChampions(onSuccess: @escaping([DiggoChampion], RequestWay) -> Void, onError: @escaping(Error) -> Void) {
        let headers = [
            "X-RapidAPI-Key": "d9c20cdbd1msh04b90ccfabbe987p1dee69jsna0ec5145b3b7",
            "X-RapidAPI-Host": "league-of-legends-champions.p.rapidapi.com"
        ]
        
        let url = URL(string: "https://league-of-legends-champions.p.rapidapi.com/champions/pt-br?page=0&size=10")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = headers
        
        dataTask = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                if let response = response as? HTTPURLResponse {
                    print("DEBUG: Status Code: \(response.statusCode)")
                }
                
                guard let data, error == nil else { return }
                do {
                    let champions = try JSONDecoder().decode([DiggoChampion].self, from: data)
                    
                    onSuccess(champions, .online)
                    print("DEBUG: DADOSONLINE AQUI: \(champions)")
                } catch {
                    onError(error)
                    print("DEBUG: Deu merda aqui.. \(error)")
                }
            }
        })
        dataTask?.resume()
    }
    
//            func getChampions(onSuccess: @escaping([Champion], RequestWay) -> Void, onError: @escaping(Error) -> Void) {
//                let headers = [
//                    "X-RapidAPI-Key": "d9c20cdbd1msh04b90ccfabbe987p1dee69jsna0ec5145b3b7",
//                    "X-RapidAPI-Host": "league-of-legends-champions.p.rapidapi.com"
//                ]
//    
//                let url = URL(string: "https://league-of-legends-champions.p.rapidapi.com/champions/pt-br?page=0&size=10")!
//                var urlRequest = URLRequest(url: url)
//                urlRequest.httpMethod = "GET"
//                urlRequest.allHTTPHeaderFields = headers
//    
//                dataTask = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) -> Void in
//                    DispatchQueue.main.async {
//                        if let response = response as? HTTPURLResponse {
//                            print("DEBUG: Status Code: \(response.statusCode)")
//                        }
//                        if let data = data,
//        //                    print("DEBUG: Dados do servidor: \(String(describing: String(data: data, encoding: .utf8)))")
//                           let champions = try? JSONDecoder().decode([Champion].self, from: data) {
//    
//                            // Dados do Servidor
//                            onSuccess(champions, .online)
//                            print("DEBUG: DADOSONLINE AQUI: \(champions)")
//                        } else if let path = Bundle.main.path(forResource: "champions", ofType: "json"),
//                                  let data = try? Data(contentsOf: URL(filePath: path)),
//                                  let champions = try? JSONDecoder().decode([Champion].self, from: data) {
//    
//                            // Dados Locais
//                            onSuccess(champions, .local)
//                            print("DEBUG: DADOSLOCAL AQUI: \(champions)")
//                        } else {
//                            onError(NSError(domain: "DEBUG: Erro ao decodificar os dados Mockados.", code: 1))
//                        }
//                    }
//                })
//                dataTask?.resume()
//            }
}

// MARK: - ChampionResponse
struct DiggoChampion: Codable {
    let champions: [ChampionResponse]
    let node: Node
    
    init(champions: [ChampionResponse], node: Node) {
        self.champions = champions
        self.node = node
    }
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
