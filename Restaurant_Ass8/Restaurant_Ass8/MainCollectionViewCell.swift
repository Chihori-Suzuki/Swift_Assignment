//
//  MainCollectionViewCell.swift
//  Restaurant_Ass8
//
//  Created by 鈴木ちほり on 2021/02/08.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "MainUICollectionViewCell"
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .fill
        stackView.alignment = .fill
        
        return stackView
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 5.0
        imageView.setContentHuggingPriority(.required, for: .vertical)
        
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = .black
//        label.setContentHuggingPriority(.required, for: .vertical)
        
        return label
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = .black
//        label.setContentHuggingPriority(.required, for: .vertical)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subTitleLabel)
//        contentView.backgroundColor = .systemTeal
        
//        NSLayoutConstraint.activate([
//            stackView.topAnchor.constraint(equalTo: topAnchor),
//            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
//            stackView.leadingAnchor.constraint(equalTo: leadingAnchor)
//        ])
        stackView.matchParent()
        imageView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.7).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(_ main: Main) {
        titleLabel.text = main.title
        subTitleLabel.text = main.subTitle
        imageView.image = UIImage(named: main.imageName)
    }

}
