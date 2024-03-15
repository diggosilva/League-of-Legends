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
        setNavBar()
        handleStates()
        viewModel.loadDataChampions()
    }
    
    func setNavBar() {
        title = "League Of Legends"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapPlusButton))
        view.backgroundColor = .systemBackground
    }
    
    @objc func didTapPlusButton() {
        let filterVC = FilterViewController(tags: viewModel.tags)
        filterVC.filterView.tags = filterVC.viewModel.tags
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
        lolView.removeFromSuperview()
    }
    
    func showLoadedState() {
        lolView.configure(diggoChampion: viewModel.diggoChampions)
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
