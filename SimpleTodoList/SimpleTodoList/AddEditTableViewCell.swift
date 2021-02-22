//
//  AddEditTableViewCell.swift
//  SimpleTodoList
//
//  Created by 鈴木ちほり on 2021/01/10.
//

import UIKit

class AddEditTableViewCell: UITableViewCell {

    let textField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        return tf
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: nil)
        
        contentView.addSubview(textField)
        textField.matchParent(padding: .init(top: 8, left: 16, bottom: 8, right: 16))
        
    }
    
    required init?(coder:NSCoder){
        fatalError("init(coder:) has not been implemented")
    }

}
