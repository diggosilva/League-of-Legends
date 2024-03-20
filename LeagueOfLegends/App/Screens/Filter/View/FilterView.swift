//
//  FilterView.swift
//  LeagueOfLegends
//
//  Created by Diggo Silva on 15/03/24.
//

import UIKit

class FilterView: UIView {
    
    lazy var filterTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FilterCell.self, forCellReuseIdentifier: FilterCell.identifier)
        tableView.rowHeight = 100
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 100, bottom: 0, right: 0)
        return tableView
    }()
    
    let viewModel: FilterViewModel
        
     init(viewModel: FilterViewModel) {
         self.viewModel = viewModel
         super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy () {
        addSubview(filterTableView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            filterTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            filterTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            filterTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            filterTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension FilterView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FilterCell.identifier, for: indexPath) as? FilterCell else { return UITableViewCell() }
        let filter = viewModel.cellForRowAt(indexPath: indexPath)
        cell.configure(filter: filter)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRowAt(indexPath: indexPath)
        tableView.reloadData()
    }
}
