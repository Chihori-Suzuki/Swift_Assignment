//
//  TodoTableViewCell.swift
//  SimpleTodoList
//
//  Created by 鈴木ちほり on 2021/01/10.
//

import UIKit

class TodoTableViewCell: UITableViewCell {

    let cellId = "TodoCell"
    let todoSymbolLabel: UILabel = {
        let lb = UILabel()
        lb.setContentHuggingPriority(.required, for: .horizontal)
        return lb
    }()
    let todoNameLabel = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: nil)
        let hStackView = HorizontalStackView(arrangedSubviews:  [todoSymbolLabel, todoNameLabel],spacing: 8, alignment: .fill, distribution: .fill)
        
        contentView.addSubview(hStackView)
        hStackView.matchParent(padding: .init(top: 8, left: 8, bottom: 8, right: 8))
        
        
    }
    
    required init?(coder:NSCoder){
        fatalError("init(coder:) has not been implemented")
    }

//    func update(with todos: ManagedTodo){
//        
//        todoSymbolLabel.text = todos.symbol
//        todoNameLabel.text = todos.title
//    }
}
