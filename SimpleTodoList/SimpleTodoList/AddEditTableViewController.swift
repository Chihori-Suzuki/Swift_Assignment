//
//  AddEditTableViewController.swift
//  SimpleTodoList
//
//  Created by 鈴木ちほり on 2021/01/10.
//

import UIKit

protocol AddEditTCVDelegate: class {
    func add(_ todo: Todo)
    func edit(_ todo: Todo)
}

class AddEditTableViewController: UITableViewController {
    
    let titleCell = AddEditTableViewCell()
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTodo))
    
    weak var delegate: AddEditTCVDelegate?
    
    var todoText: Todo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if todoText == nil {
            title = "Add todo items"
        } else {
            title = "Edit todo item"
            titleCell.textField.text = todoText?.title
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissViewController))
        navigationItem.rightBarButtonItem = doneButton
        titleCell.textField.addTarget(self, action: #selector(textEditingChanged(_:)), for: .editingChanged)
        updateDoneButtonState()
    }
    
    @objc func textEditingChanged(_ sender: UITextField){
        updateDoneButtonState()
    }
    
    @objc func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func doneTodo(){
        let newTodo = Todo(symbol: "", title: titleCell.textField.text!)
        if self.todoText == nil {
            delegate?.add(newTodo)
        } else {
            delegate?.edit(newTodo)
        }
        
        dismiss(animated: true, completion: nil)
    }
    private func updateDoneButtonState() {
        let nameText = titleCell.textField.text ?? ""
        doneButton.isEnabled = !nameText.isEmpty
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return titleCell
    }
    
}
