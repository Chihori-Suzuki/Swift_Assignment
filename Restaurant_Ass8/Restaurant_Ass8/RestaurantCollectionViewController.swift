//
//  RestaurantCollectionViewController.swift
//  Restaurant_Ass8
//
//  Created by 鈴木ちほり on 2021/02/08.
//

import UIKit

private let reuseIdentifier = "Cell"

class RestaurantCollectionViewController: UICollectionViewController {

    enum Section {
        case header
        case main
    }
    
    enum Layout {
        case grid
        case column
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    var sections = [Section]()
    
    
    var filterdItems = Item.restaurantList
    
    var activeLayout: Layout = .grid
    
    var filteredItemSnapshot: NSDiffableDataSourceSnapshot<Section, Item> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.header])
        snapshot.appendItems(Item.headerList, toSection: .header)
        
        snapshot.appendSections([.main])
        snapshot.appendItems(filterdItems, toSection: .main)
        
        sections = snapshot.sectionIdentifiers
        return snapshot
    }
    
    var layoutBtn = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Restaurant"
        layoutBtn = .init(image: UIImage(systemName: "rectangle.grid.1x2"), style: .done, target: self, action: #selector(generateGridLayout(_:)))
        navigationItem.leftBarButtonItem = layoutBtn
        
        collectionView.backgroundColor = UIColor.Theme1.white
        collectionView.setCollectionViewLayout(createLayout(), animated: false)
        collectionView.register(HeaderCollectionViewCell.self, forCellWithReuseIdentifier: HeaderCollectionViewCell.reuseIdentifier)
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.reuseIdentifier)
        
        congfigureDataSource()
    }

    @objc func generateGridLayout(_ sender: UIBarButtonItem)  {
        
        switch self.activeLayout {
        case .grid:
            self.activeLayout = .column
            layoutBtn.image = UIImage(systemName: "square.grid.2x2")
            
        case .column:
            self.activeLayout = .grid
            layoutBtn.image = UIImage(systemName: "rectangle.grid.1x2")
            
        //square.grid.2x2
        }
        collectionView.collectionViewLayout = createLayout()
        
    }

    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let section = self.sections[sectionIndex]
            
            switch section {
            case .header:
                let item = NSCollectionLayoutItem(
                  layoutSize: .init(
                    widthDimension: .fractionalWidth(0.5),
                    heightDimension: .fractionalWidth(0.3)
                  )
                )
                item.contentInsets = .init(top: 0, leading: 4, bottom: 0, trailing: 4)
                
                let group = NSCollectionLayoutGroup.horizontal(
                  layoutSize: .init(
                    widthDimension: .fractionalWidth(0.5),
                    heightDimension: .absolute(100)
                  ),
                  subitems: [item]
                )
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = .init(top: 8, leading: 0, bottom: 10, trailing: 0)
                
                return section
                
            case .main:
                
                switch self.activeLayout {
                case .grid:
                    
                    let item = NSCollectionLayoutItem(
                        layoutSize: .init(
                            widthDimension: .fractionalWidth(1.0),
                            heightDimension: .fractionalWidth(0.5)
                        )
                    )
                    item.contentInsets = .init(top: 0, leading: 10, bottom: 20, trailing: 10)
                    
                    let group = NSCollectionLayoutGroup.horizontal(
                        layoutSize: .init(
                            widthDimension: .fractionalWidth(1.0),
                            heightDimension: .estimated(200)
                        ),
                        subitem: item,
                        count: 2
                    )
                    let section = NSCollectionLayoutSection(group: group)
                    //                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                    section.contentInsets = .init(top: 8, leading: 0, bottom: 20, trailing: 0)
                    
                    return section
                case .column:
                    let item = NSCollectionLayoutItem(
                        layoutSize: .init(
                            widthDimension: .fractionalWidth(1.0),
                            heightDimension: .fractionalWidth(0.5)
                        )
                    )
                    item.contentInsets = .init(top: 0, leading: 10, bottom: 20, trailing: 10)
                    
                    let group = NSCollectionLayoutGroup.horizontal(
                        layoutSize: .init(
                            widthDimension: .fractionalWidth(1.0),
                            heightDimension: .estimated(250)
                        ),
                        subitem: item,
                        count: 1
                    )
                    let section = NSCollectionLayoutSection(group: group)
                    //                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                    section.contentInsets = .init(top: 8, leading: 0, bottom: 20, trailing: 0)
                    
                    return section
                    
                }
            }
        }
        return layout
    }
    
    func congfigureDataSource() {
        dataSource = .init(collectionView: collectionView, cellProvider: {(collectionView, indexPath, item) -> UICollectionViewCell? in
            
            let section = self.sections[indexPath.section]
            switch section {
            case .header:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderCollectionViewCell.reuseIdentifier, for: indexPath) as! HeaderCollectionViewCell
                cell.configureCell(item.header!)
                
                return cell
                
            case .main:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.reuseIdentifier, for: indexPath) as! MainCollectionViewCell
                cell.configureCell(item.main!)
                
                return cell
                
            }
        })
        

        dataSource.apply(filteredItemSnapshot, animatingDifferences: true, completion: nil)
    }
    
    
    
    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print(indexPath.section)
        if indexPath.section == 0 {
            
            let selectedItem = Item.headerList[indexPath.item]
            let selectedItemText = selectedItem.header?.name
//            print(selectedItem.header!.name)
            
            if let filterString = selectedItemText {
                filterdItems = Item.restaurantList.filter({
                    ($0.main?.subTitle.localizedCaseInsensitiveContains(filterString))! })
            } else {
                filterdItems = Item.restaurantList
            }
//            print(filterdItems)
            dataSource.apply(filteredItemSnapshot, animatingDifferences: true, completion: nil)
            
        }
    }
    
}

