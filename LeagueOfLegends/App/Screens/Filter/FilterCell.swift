//
//  TagsCell.swift
//  LeagueOfLegends
//
//  Created by Diggo Silva on 15/03/24.
//

import UIKit

class FilterCell: UICollectionViewCell {
    static let identifier = "TagsCell"
    
    lazy var imageTag: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "assassin")
        image.clipsToBounds = true
        return image
    }()
    
    lazy var nameTag: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(roles: String) {
        nameTag.text = roles
        imageTag.image = UIImage(named: roles)
    }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy () {
        addSubview(imageTag)
        addSubview(nameTag)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            imageTag.topAnchor.constraint(equalTo: topAnchor),
            imageTag.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageTag.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageTag.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            nameTag.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameTag.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
        ])
    }
}
