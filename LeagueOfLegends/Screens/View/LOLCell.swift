//
//  LOLCell.swift
//  LeagueOfLegends
//
//  Created by Diggo Silva on 12/03/24.
//

import UIKit
import SDWebImage

class LOLCell: UICollectionViewCell {
    static let identifier = "LOLCell"
    
    lazy var imageChamp: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var nameChamp: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "NOME AQUI"
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .black
        label.backgroundColor = .white
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(response: DiggoChampion) {
        guard let url = URL(string: response.image) else { return }
        imageChamp.sd_setImage(with: url)
        nameChamp.text = response.name
    }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy () {
        addSubview(imageChamp)
        addSubview(nameChamp)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            imageChamp.topAnchor.constraint(equalTo: topAnchor),
            imageChamp.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageChamp.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageChamp.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            nameChamp.centerXAnchor.constraint(equalTo: imageChamp.centerXAnchor),
            nameChamp.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
    }
}
