//
//  ChampCell.swift
//  LeagueOfLegends
//
//  Created by Diggo Silva on 12/03/24.
//

import UIKit
import SDWebImage

class ChampCell: UICollectionViewCell {
    static let identifier = "ChampCell"
    
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
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .black
        label.backgroundColor = .white
        label.textAlignment = .center
        return label
    }()
    
    lazy var rolesChamp: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .black
        label.backgroundColor = .white
        label.textAlignment = .center
        return label
    }()
    
    lazy var imageDifficultyColor: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "circle.circle.fill")
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(diggoChampion: DiggoChampion) {
        imageChamp.sd_setImage(with: diggoChampion.imageUrl, placeholderImage: UIImage(systemName: "circle.slash")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal))
        nameChamp.text = diggoChampion.name
        rolesChamp.text = "\(diggoChampion.roles.joined(separator: ", "))"
        imageDifficultyColor.tintColor = diggoChampion.colorDifficulty
    }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy () {
        addSubview(imageChamp)
        addSubview(nameChamp)
        addSubview(rolesChamp)
        addSubview(imageDifficultyColor)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            imageChamp.topAnchor.constraint(equalTo: topAnchor),
            imageChamp.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageChamp.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageChamp.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            nameChamp.centerXAnchor.constraint(equalTo: imageChamp.centerXAnchor),
            nameChamp.bottomAnchor.constraint(equalTo: rolesChamp.topAnchor, constant: -5),
            
            rolesChamp.centerXAnchor.constraint(equalTo: imageChamp.centerXAnchor),
            rolesChamp.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            
            imageDifficultyColor.leadingAnchor.constraint(equalTo: nameChamp.trailingAnchor, constant: 2),
            imageDifficultyColor.centerYAnchor.constraint(equalTo: nameChamp.centerYAnchor),
        ])
    }
}
