//
//  FilterViewController.swift
//  LeagueOfLegends
//
//  Created by Diggo Silva on 15/03/24.
//

import UIKit

protocol FilterViewControllerDelegate: AnyObject {
    func didUpdateFilters(filters: [Filter])
}

class FilterViewController: UIViewController {
    
    var filterView = FilterView()
    var viewModel: FilterViewModel
    
    weak var delegate: FilterViewControllerDelegate?
    
    init(roles: [Filter], delegate: FilterViewControllerDelegate?) {
        self.viewModel = FilterViewModel(roles: roles)
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = filterView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
    }
    
    func setNavBar() {
        title = "Roles"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapDoneButton))
        view.backgroundColor = .systemBackground
    }
    
    @objc func didTapDoneButton() {
        print("Volta pra primeira tela filtrando a Role selecionada")
        delegate?.didUpdateFilters(filters: filterView.filters)
        navigationController?.popToRootViewController(animated: true)
    }
}
