//
//  ViewController.swift
//  LOL
//
//  Created by Diggo Silva on 11/03/24.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var service = Service()
    var diggoChampionList: [DiggoChampion] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        service.getChampions { champions, requestStatus in
//            self.champs = champions
            print(champions)
        } onError: { error in
            print("DEBUG: Algo de errado não está certo..")
        }

    }

}
