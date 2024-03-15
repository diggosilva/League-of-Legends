//
//  TagsCell.swift
//  LeagueOfLegends
//
//  Created by Diggo Silva on 15/03/24.
//

import UIKit

class FilterCell: UICollectionViewCell {
    static let identifier = "TagsCell"
    
    lazy var tagImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "assassin")
        image.clipsToBounds = true
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(viewModel: [String]) {
        for tag in viewModel {
            tagImage.image = UIImage(named: tag)
        }
    }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy () {
        addSubview(tagImage)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            tagImage.topAnchor.constraint(equalTo: topAnchor),
            tagImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            tagImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            tagImage.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
