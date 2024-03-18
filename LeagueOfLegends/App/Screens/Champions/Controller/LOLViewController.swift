//
//  ChampViewController.swift
//  LeagueOfLegends
//
//  Created by Diggo Silva on 11/03/24.
//

import UIKit

class ChampViewController: UIViewController {
    private var champView = ChampView()
    private lazy var viewModel = ChampViewModel()
    
    override func loadView() {
        super.loadView()
        view = champView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        handleStates()
        viewModel.loadDataChampions()
    }
    
    func setNavBar() {
        title = "League Of Legends"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapPlusButton))
        view.backgroundColor = .systemBackground
    }
    
    @objc func didTapPlusButton() {
        let filterVC = FilterViewController(roles: viewModel.filters)
        filterVC.filterView.filters = filterVC.viewModel.roles
        navigationController?.pushViewController(filterVC, animated: true)
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
        champView.removeFromSuperview()
    }
    
    func showLoadedState() {
        champView.configure(diggoChampion: viewModel.diggoChampions)
        champView.collectionView.reloadData()
        champView.spinner.stopAnimating()
    }
    
    func showErrorState() {
        let alert = UIAlertController(title: "Ocorreu um erro!", message: "Tentar Novamente?", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Sim", style: .default) { action in
            self.viewModel.loadDataChampions()
        }
        let nok = UIAlertAction(title: "Não", style: .cancel) { action in
            self.champView.spinner.stopAnimating()
            self.champView.errorLabel.isHidden = false
        }
        alert.addAction(ok)
        alert.addAction(nok)
        present(alert, animated: true)
    }
}
