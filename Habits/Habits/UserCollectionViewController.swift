//
//  UserCollectionViewController.swift
//  Habits
//
//  Created by 鈴木ちほり on 2021/02/12.
//

import UIKit

private let reuseIdentifier = "Cell"

class UserCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    typealias DataSourceType =
       UICollectionViewDiffableDataSource<ViewModel.Section,
       ViewModel.Item>
    
    enum ViewModel {
        typealias Section = Int
    
        struct Item: Hashable {
            let user: User
            let isFollowed: Bool
        }
    }
    
//    struct Model {
//        var usersByID = [String:User]()
//        var followedUsers: [User] {
//            return Array(usersByID.filter
//               { Settings.shared.followedUserIDs.contains($0.key)
//               }.values)
//        }
//    }
    
    var dataSource: DataSourceType!
//    var model = Model()
}
