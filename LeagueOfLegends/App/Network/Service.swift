//
//  Service.swift
//  LeagueOfLegends
//
//  Created by Diggo Silva on 11/03/24.
//

import Foundation

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
    
    func getChampions(onSuccessDiggoChampions: @escaping([DiggoChampion]) -> Void, onError: @escaping(Error) -> Void) {
        
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
                        diggoChampions.append(DiggoChampion(name: champion.value.name, image: champion.value.image.full, difficulty: champion.value.info.difficulty, roles: champion.value.tags))
                    }
                    diggoChampions = diggoChampions.sorted { (champion1, champion2) -> Bool in
                        return champion1.name.caseInsensitiveCompare(champion2.name) == .orderedAscending
                    }
                    // Dados do Servidor
                    onSuccessDiggoChampions(diggoChampions)
                } else {
                    onError(NSError(domain: "DEBUG: Erro ao decodificar os dados Mockados.", code: 1))
                }
            }
        })
        dataTask?.resume()
    }
}
