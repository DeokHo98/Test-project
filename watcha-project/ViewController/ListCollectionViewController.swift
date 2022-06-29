//
//  ListCollectionViewController.swift
//  watcha-project
//
//  Created by 정덕호 on 2022/06/29.
//

import UIKit

class ListCollectionViewController: UICollectionViewController {

    
    //MARK: - lifeCycle
    
    init() {
        let layout = UICollectionViewCompositionalLayout { section, env in
            switch section {
            case 0:
                let item = NSCollectionLayoutItem(
                    layoutSize: .init(widthDimension: .fractionalWidth(1),
                       heightDimension: .fractionalHeight(1))
                )
                item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
                let group = NSCollectionLayoutGroup.vertical(
                   layoutSize: .init(widthDimension: .fractionalWidth(1),
                                     heightDimension: .estimated(60)),
                   subitems: [item]
                )
                group.contentInsets.top = 10
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .none
                section.boundarySupplementaryItems = [
                ]
                section.contentInsets = .init(top: 20, leading: 0, bottom: 0, trailing: 0)
                return section
            default:
                return NSCollectionLayoutSection(
                   group: NSCollectionLayoutGroup(
                       layoutSize: NSCollectionLayoutSize(
                           widthDimension: .absolute(0), heightDimension: .absolute(0)
                       )
                   )
                )
            }
        }
        super.init(collectionViewLayout: layout)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setAttribute()
        setCell()
    }
    
    //MARK: - HelperFunction
    func setAttribute() {
        collectionView.backgroundColor = .black
    }
    func setCell() {
        collectionView.register(TrendingCell.self, forCellWithReuseIdentifier: TrendingCell.identifier)
    }

    //MARK: - DatSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendingCell.identifier, for: indexPath) as! TrendingCell
        return cell
    }
}
