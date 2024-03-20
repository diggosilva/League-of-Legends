//
//  FilterCell.swift
//  LeagueOfLegends
//
//  Created by Diggo Silva on 15/03/24.
//

import UIKit

class FilterCell: UITableViewCell {
    static let identifier = "FilterCell"
    
    lazy var imageRole: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    
    lazy var nameRole: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(filter: Filter) {
        nameRole.text = filter.name
        imageRole.image = UIImage(named: filter.name)
        self.accessoryType = filter.isSelected ? .checkmark : .none
    }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy () {
        addSubview(imageRole)
        addSubview(nameRole)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            imageRole.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            imageRole.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            imageRole.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            imageRole.widthAnchor.constraint(equalToConstant: 80),
            
            nameRole.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameRole.leadingAnchor.constraint(equalTo: imageRole.trailingAnchor, constant: 10),
            nameRole.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
        ])
    }
}
