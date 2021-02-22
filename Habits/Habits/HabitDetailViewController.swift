//
//  HabitDetailViewController.swift
//  Habits
//
//  Created by 鈴木ちほり on 2021/02/12.
//

import UIKit

class HabitDetailViewController: UIViewController {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var infoLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    
    var habit: Habit!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        nameLabel.text = habit.name
        categoryLabel.text = habit.categoty.name
        infoLabel.text = habit.info
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init?(coder: NSCoder, habit: Habit) {
        self.habit = habit
        super.init(coder: coder)
    }
    
    typealias DataSourceType =
       UICollectionViewDiffableDataSource<ViewModel.Section,
       ViewModel.Item>
    
    enum ViewModel {
        enum Section: Hashable {
            case leaders(count: Int)
            case remaining
        }
    
        enum Item: Hashable, Comparable {
            case single(_ stat: UserCount)
            case multiple(_ stats: [UserCount])
    
            static func < (lhs:
               HabitDetailViewController.ViewModel.Item,
               rhs: HabitDetailViewController.ViewModel.Item) -> Bool {
                switch (lhs, rhs) {
                case (.single(let lCount), .single(let rCount)):
                    return lCount.count < rCount.count
                case (.multiple(let lCounts), .multiple(let rCounts)):
                    return lCounts.first!.count < rCounts.first!.count
                case (.single, .multiple):
                    return false
                case (.multiple, .single):
                    return true
                }
            }
        }
    }
    struct Model {
        var habitStatistics: HabitStatistics?
        var userCounts: [UserCount] {
            habitStatistics?.userCounts ?? []
        }
    }
    
    var dataSource: DataSourceType!
    var model = Model()
    
    func update() {
        HabitStatisticsRequest(habitNames: [habit.name]).send { result in
            if case .success(let statistics) = result, statistics.count > 0 {
                self.model.habitStatistics = statistics[0]
            } else {
                self.model.habitStatistics = nil
            }
    
            DispatchQueue.main.async {
                self.updateCollectionView()
                //updateCollectionView
            }
        }
    }
    
    
    
}
