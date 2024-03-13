//
//  LOLViewController.swift
//  LeagueOfLegends
//
//  Created by Diggo Silva on 11/03/24.
//

import UIKit

class LOLViewController: UIViewController {
    private var lolView = LOLView()
    private lazy var viewModel = LOLViewModel()
    
    override func loadView() {
        super.loadView()
        view = lolView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "League Of Legends"
        
        view.backgroundColor = .systemBackground
        handleStates()
        viewModel.loadDataChampions()
    }
    
    func handleStates() {
        viewModel.state.bind { state in
            switch state {
            case .loading:
                self.showLoadingState()
            case .loaded:
                self.showLoadedState()
            case .error:
                self.showErrorState()
            }
        }
    }
    
    func showLoadingState() {
        lolView.removeFromSuperview()
    }
    
    func showLoadedState() {
        lolView.configure(championResponse: viewModel.diggoChampions)
        lolView.collectionView.reloadData()
        lolView.spinner.stopAnimating()
    }
    
    func showErrorState() {
        let alert = UIAlertController(title: "Ocorreu um erro!", message: "Tentar Novamente?", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Sim", style: .default) { action in
            self.viewModel.loadDataChampions()
        }
        let nok = UIAlertAction(title: "Não", style: .cancel) { action in
            self.lolView.spinner.stopAnimating()
            self.lolView.errorLabel.isHidden = false
        }
        alert.addAction(ok)
        alert.addAction(nok)
        present(alert, animated: true)
    }
}
