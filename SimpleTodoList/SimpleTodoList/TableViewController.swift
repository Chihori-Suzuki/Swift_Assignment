//
//  TableViewController.swift
//  SimpleTodoList
//
//  Created by 鈴木ちほり on 2021/01/09.
//

import UIKit
import CoreData

class TableViewController: FetchedResultsTableViewController, AddEditTCVDelegate {

    let cellId = "TodoCell"
    var toDos: [[Todo]] = [
        [
            Todo(symbol: "✓", title: "Feed my cat")
            ,Todo(symbol: "✓", title: "Make a lunch")
        ],
        [
            Todo(symbol: "✓", title: "Clean my room")
            ,Todo(symbol: "✓", title: "do the laundry")
        ],
        [
            Todo(symbol: "✓", title: "Study about Swift language")
            ,Todo(symbol: "✓", title: "return the books")
        ]
    ]
    
    var sectionTitles: [String] = ["High Priority", "Midium Priority", "Low Priority"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.register(TodoTableViewCell.self, forCellReuseIdentifier: cellId)
        title = "Todo items"
        
        navigationItem.leftBarButtonItem = editButtonItem
        let deleteButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteTodoItems))
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewTodo))
        navigationItem.rightBarButtonItems = [addButton, deleteButton]
        tableView.allowsMultipleSelectionDuringEditing = true
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
    }
    private func navigateToAddEditTVC() {
        let addEditTVC = AddEditTableViewController(style: .grouped)
        addEditTVC.delegate = self
        let addEditNC = UINavigationController(rootViewController: addEditTVC)
        present(addEditNC, animated: true, completion: nil)
    }
    
    @objc func addNewTodo(){
        
        navigateToAddEditTVC()
    }
    func add(_ toDo: Todo) {
        toDos[1].append(toDo)
//        print("todo count:\(todo[1].count)")
//        print("todo index:\(IndexPath(row: todo[1].count - 1, section: 1))")
        tableView.insertRows(at: [IndexPath(row: toDos[1].count - 1, section: 1)], with: .automatic)
    }
    func edit(_ toDo: Todo) {
        if let indexPath = tableView.indexPathForSelectedRow {
            toDos[indexPath.section].remove(at: indexPath.row)
            toDos[indexPath.section].insert(toDo, at: indexPath.row)
            tableView.reloadRows(at: [indexPath], with: .automatic)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
     
    // CoreData
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func createSection(section: String) {
        let newTitle = ManagedTodo(context: context)
        for section in sectionTitles {
            newTitle.sectionTitle = section
        }
        
        try? context.save()
    }
    
    func createTodos(_ toDos: [Todo]) {
        let newTodo = ManagedTodo(context: context)
        for todo in toDos {
            newTodo.title = todo.title
            newTodo.symbol = todo.symbol
        }
    }
    
    lazy var fetchedResultsController: NSFetchedResultsController<ManagedTodo> = {
        let request: NSFetchRequest<ManagedTodo> = ManagedTodo.fetchRequest()
        
        let frc = NSFetchedResultsController<ManagedTodo>(
            fetchRequest: request,
            managedObjectContext: context,
            sectionNameKeyPath: "sectionTitle",
            cacheName: nil)
        return frc
    }()
    
//    func updateUI() {
//      try? fetchedResultsController.performFetch()
//      tableView.reloadData()
//    }
    
    // -- Mark TableView delegate
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultsController.sections, sections.count > 0 {
          return sections[section].numberOfObjects
        } else {
          return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let todos = fetchedResultsController.object(at: indexPath)
//        let todos = toDos[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
       as! TodoTableViewCell
        cell.todoSymbolLabel.text = todos.symbol
        cell.todoNameLabel.text = todos.title
        cell.accessoryType = UITableViewCell.AccessoryType.detailDisclosureButton
        cell.showsReorderControl = true
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let addEditTVC = AddEditTableViewController(style: .grouped)
        addEditTVC.delegate = self
        addEditTVC.todoText = toDos[indexPath.section][indexPath.row]
        let addEditNC = UINavigationController(rootViewController: addEditTVC)
        present(addEditNC, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let sections = fetchedResultsController.sections, sections.count > 0 {
          return sections[section].name
        } else {
          return nil
        }
      }

    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let removedTodo = toDos[sourceIndexPath.section].remove(at: sourceIndexPath.row)
        toDos[destinationIndexPath.section].insert(removedTodo, at: destinationIndexPath.row)
//        tableView.reloadRows(at: [sourceIndexPath], with: .automatic)
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !tableView.isEditing {
            print(toDos[indexPath.section][indexPath.row])
            if toDos[indexPath.section][indexPath.row].symbol == ""  {
                toDos[indexPath.section][indexPath.row].symbol = "✓"
            }else{
                toDos[indexPath.section][indexPath.row].symbol = ""
            }
            tableView.reloadRows(at: [indexPath], with: .automatic)
        } else {
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        }
    }
    
    @objc func deleteTodoItems() {
        if let indexPaths = tableView.indexPathsForSelectedRows {
            var newIndexPath = indexPaths
            newIndexPath.sort { $0 < $1 }
            
            for indexPath in newIndexPath.reversed() {
                print(indexPath)
                toDos[indexPath.section].remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                }
        }
    }
}
