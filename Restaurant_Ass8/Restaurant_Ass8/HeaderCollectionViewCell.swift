//
//  HeaderCollectionViewCell.swift
//  Restaurant_Ass8
//
//  Created by 鈴木ちほり on 2021/02/08.
//

import UIKit

class HeaderCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "HeaderUICollectionViewCell"
    
    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.layer.cornerRadius = 0.5
        label.textColor = .black
//        label.setContentHuggingPriority(.required, for: .vertical)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(label)
        contentView.backgroundColor = .white
        label.centerXYin(contentView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(_ header: Header)  {
        label.text = header.name
    }
    
}
