//
//  RestaurantCollectionViewController.swift
//  RestaurantCollectionView
//
//  Created by 鈴木ちほり on 2021/02/06.
//

import UIKit

private let reuseIdentifier = "StateCell"

class RestaurantCollectionViewController: UICollectionViewController, UISearchResultsUpdating {
    
    enum Section: Int, CaseIterable {
        case header
        case main
    }
    
    var sections = [Section]()
    
    private let headerItems = ["Mexican","Asian","American","Breakfast", "Lunch", "Dinner"]
    
    private let items = [
        "Alabama", "Alaska", "Arizona", "Arkansas", "California",
        "Colorado", "Connecticut", "Delaware", "Florida",
        "Georgia", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa",
        "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland",
        "Massachusetts", "Michigan", "Minnesota", "Mississippi",
        "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire",
        "New Jersey", "New Mexico", "New York", "North Carolina",
        "North Dakota", "Ohio", "Oklahoma", "Oregon", "Pennsylvania",
        "Rhode Island", "South Carolina", "South Dakota", "Tennessee",
        "Texas", "Utah", "Vermont", "Virginia", "Washington",
        "West Virginia", "Wisconsin", "Wyoming"
    ]
    
    lazy var filteredItems: [String] = self.items
    
    var dataSource: UICollectionViewDiffableDataSource<Section, String>!
    
    
    var filteredItemsSnapshot: NSDiffableDataSourceSnapshot<Section, String> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        for section in Section.allCases {
            snapshot.appendSections([section])
            switch (section) {
            case .header:
                snapshot.appendItems(headerItems)
            default:
                snapshot.appendItems(filteredItems)
            }
        }
        
        return snapshot
    }
    
    
    let searchController = UISearchController(searchResultsController: nil)
    
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, String>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            let section = self.sections[indexPath.section]
            switch section {
            case .header:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! RestaurantCollectionViewCell
                
                cell.label.text = item
                return cell
            case .main:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! RestaurantCollectionViewCell
            
                cell.label.text = item
                return cell
            }
            
            
        })
        dataSource.apply(filteredItemsSnapshot)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchString = searchController.searchBar.text, !searchString.isEmpty{
            filteredItems = items.filter({ $0.localizedCaseInsensitiveContains(searchString) })
        } else {
            filteredItems = items
        }
//        collectionView.reloadData()
        dataSource.apply(filteredItemsSnapshot, animatingDifferences: true, completion: nil)
    }
    
    private func generateLayout() -> UICollectionViewLayout {
        let spacing: CGFloat = 10
        // 1. define item
        let itemSize1 = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let item1 = NSCollectionLayoutItem(layoutSize: itemSize1)
        item1.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let itemSize2 = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item2 = NSCollectionLayoutItem(layoutSize: itemSize2)
        item2.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        
        //2. group
        let groupSize1 = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(200))
        let group1 = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize1, subitem: item1, count: 2) //1 item per group
        group1.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: 0, bottom: 0, trailing: 0)
        
        let groupSize2 = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(200))
        let group2 = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize2, subitem: item2, count: 2) //1 item per group
        group2.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: 0, bottom: 0, trailing: 0)
        
        
        
        //3. section
        let section1 = NSCollectionLayoutSection(group: group1)
        section1.interGroupSpacing = spacing
        
        let section2 = NSCollectionLayoutSection(group: group2)
        section2.interGroupSpacing = spacing
        
        
        let layout = UICollectionViewCompositionalLayout{(sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let section = Section.allCases[sectionIndex]
            switch (section) {
            case .header:
                return section1
            case .main:
                return section2
            }
        }
        return layout
//        return UICollectionViewCompositionalLayout(section: section)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self //
        searchController.obscuresBackgroundDuringPresentation = false
        
        collectionView.backgroundColor = .white
        collectionView.setCollectionViewLayout(generateLayout(), animated: false) //
        collectionView.register(RestaurantCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        createDataSource()
    }

    /*
    // MARK: - Navigation
    */

    // MARK: UICollectionViewDataSource

//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 2
//    }
//
//
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return filteredItems.count
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! RestaurantCollectionViewCell
//
//        cell.label.text = filteredItems[indexPath.item]
//
//        return cell
//    }
//
    
    

}
