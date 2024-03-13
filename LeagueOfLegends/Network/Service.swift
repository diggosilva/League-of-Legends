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
    
    func getChampions(onSuccess: @escaping(ChampionResponse) -> Void, onError: @escaping(Error) -> Void, onSuccessDiggoChampions: @escaping([DiggoChampion], RequestWay) -> Void) {
        let headers = [
            "X-RapidAPI-Key": "d9c20cdbd1msh04b90ccfabbe987p1dee69jsna0ec5145b3b7",
            "X-RapidAPI-Host": "league-of-legends-champions.p.rapidapi.com"
        ]
        
        let url = URL(string: "https://league-of-legends-champions.p.rapidapi.com/champions/pt-br?page=0&size=10")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = headers
        
        dataTask = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) -> Void in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                if let response = response as? HTTPURLResponse {
                    print("DEBUG: Status Code: \(response.statusCode)")
                }
                if let data = data,
                   let response = try? JSONDecoder().decode(ChampionResponse.self, from: data) {
                    var diggoChampions: [DiggoChampion] = []
                    
                    for champion in response.champions {
                        diggoChampions.append(DiggoChampion(name: champion.node.championName, image: champion.node.championSplash))
                    }
                    
                    // Dados do Servidor
                    onSuccessDiggoChampions(diggoChampions, .online)
                    print("DEBUG: SERVERDATA aqui: \(response)")
                } else if let path = Bundle.main.path(forResource: "champions", ofType: "json"),
                          let data = try? Data(contentsOf: URL(filePath: path)),
                          let response = try? JSONDecoder().decode(ChampionResponse.self, from: data) {
                    var diggoChampions: [DiggoChampion] = []
                    
                    for champion in response.champions {
                        diggoChampions.append(DiggoChampion(name: champion.node.championName, image: champion.node.championSplash))
                    }
                    
                    // Dados Locais
                    onSuccessDiggoChampions(diggoChampions, .local)
                    print("DEBUG: MOCKDATA aqui: \(diggoChampions)")
                } else {
                    onError(NSError(domain: "DEBUG: Erro ao decodificar os dados Mockados.", code: 1))
                }
            }
        })
        dataTask?.resume()
    }
}

// DÁ ERRO AO TRAZER DADOS DO SERVIDOR E O CÓDIGO NÃO SEGUE PARA PUXAR DADOS MOCKADOS

//    func getChampions(onSuccess: @escaping(Response, RequestWay) -> Void, onError: @escaping(Error) -> Void) {
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
//            DispatchQueue.main.async {
//                if let response = response as? HTTPURLResponse {
//                    print("DEBUG: Status Code: \(response.statusCode)")
//                }
//                if let data = data {
//                    do {
//                        let response = try JSONDecoder().decode(Response.self, from: data)
//                         var diggoChampions: [DiggoChampion] = []
//
//                         for champion in response.champions {
//                             diggoChampions.append(DiggoChampion(name: champion.node.championName, image: champion.node.championSplash))
//                         }
//
//                         // Dados do Servidor
//                         onSuccess(response, .online)
//                         print("DEBUG: SERVERDATA aqui: \(response)")
//                    } catch {
//                        onError(error)
//                        print("DEBUG: Erro ao carregar dados do SERVIDOR..")
//                    }
//                } else if let path = Bundle.main.path(forResource: "champions", ofType: "json") {
//                    do {
//                        let data = try Data(contentsOf: URL(filePath: path))
//                        let response = try JSONDecoder().decode(Response.self, from: data)
//                  var diggoChampions: [DiggoChampion] = []
//
//                  for champion in response.champions {
//                      diggoChampions.append(DiggoChampion(name: champion.node.championName, image: champion.node.championSplash))
//                  }
//
//                  // Dados Locais
//                  onSuccess(response, .local)
//                  print("DEBUG: MOCKDATA aqui: \(response)")
//                    } catch {
//                        onError(error)
//                        print("DEBUG: Erro ao carregar dados do MOCKADOS..")
//                    }
//                } else {
//                    onError(NSError(domain: "DEBUG: Erro ao decodificar os dados Mockados.", code: 1))
//                }
//            }
//        })
//        dataTask?.resume()
//    }
