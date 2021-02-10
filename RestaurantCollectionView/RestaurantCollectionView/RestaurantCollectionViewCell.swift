//
//  RestaurantCollectionViewCell.swift
//  RestaurantCollectionView
//
//  Created by 鈴木ちほり on 2021/02/06.
//

import UIKit

class RestaurantCollectionViewCell: UICollectionViewCell {
    let label = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(label)
        contentView.backgroundColor = .systemTeal
        label.centerXYin(contentView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
