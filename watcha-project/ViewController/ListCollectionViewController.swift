//
//  ListCollectionViewController.swift
//  watcha-project
//
//  Created by 정덕호 on 2022/06/29.
//

import UIKit

class ListCollectionViewController: UICollectionViewController {

    //MARK: - Property
    var trendingViewModel: TrendingKeyWordViewModel = TrendingKeyWordViewModel()
    
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
                                     heightDimension: .estimated(50)),
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
        trendingViewModel.fetchTrandingKeword()
        setAttribute()
        setCell()
        setBinding()
    }
    
    //MARK: - HelperFunction
    func setAttribute() {
        collectionView.backgroundColor = .black
    }
    func setCell() {
        collectionView.register(TrendingCell.self, forCellWithReuseIdentifier: TrendingCell.identifier)
        collectionView.register(MostPopularCell.self, forCellWithReuseIdentifier: MostPopularCell.identifier)
    }
    func setBinding() {
        trendingViewModel.fetchSuccess.bind { [weak self] _ in
            self?.collectionView.reloadData()
        }
        trendingViewModel.serviceError.bind { [weak self] _ in
            self?.collectionView.reloadData()
        }
    }

    //MARK: - DatSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trendingViewModel.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendingCell.identifier, for: indexPath) as! TrendingCell
            cell.keywordLabel.text = trendingViewModel.keyword(indexPath: indexPath.row)
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MostPopularCell.identifier, for: indexPath) as! MostPopularCell
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}
