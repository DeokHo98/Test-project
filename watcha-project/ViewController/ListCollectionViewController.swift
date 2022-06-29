//
//  ListCollectionViewController.swift
//  watcha-project
//
//  Created by 정덕호 on 2022/06/29.
//

import UIKit

class ListCollectionViewController: UICollectionViewController {

    //MARK: - Property
    var trendingViewModel: TrendingKeyWordViewModelList = TrendingKeyWordViewModelList()
    var mostPopularViewModel: GIFViewModelList = GIFViewModelList()
    
    //MARK: - lifeCycle
    
    init() {
        let layout = UICollectionViewCompositionalLayout { section, env in
            switch section {
            case 0:
                let item = NSCollectionLayoutItem(
                    layoutSize: .init(widthDimension: .fractionalWidth(1),
                       heightDimension: .fractionalHeight(1))
                )
                let group = NSCollectionLayoutGroup.vertical(
                   layoutSize: .init(widthDimension: .fractionalWidth(1),
                                     heightDimension: .estimated(45)),
                   subitems: [item]
                )
                group.contentInsets.top = 10
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .none
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                            heightDimension: .estimated(50)),
                          elementKind: UICollectionView.elementKindSectionHeader,
                          alignment: .topLeading)
                ]
                section.contentInsets = .init(top: -10, leading: 0, bottom: 10, trailing: 0)
                return section
            case 1:
                let item = NSCollectionLayoutItem(
                    layoutSize: .init(widthDimension: .fractionalWidth(1),
                       heightDimension: .fractionalHeight(1))
                )
                item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
                let group = NSCollectionLayoutGroup.horizontal(
                   layoutSize: .init(widthDimension: .fractionalWidth(1),
                                     heightDimension: .fractionalWidth(1/3)),
                   subitem: item, count: 2
                )
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .none
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                            heightDimension: .estimated(50)),
                          elementKind: UICollectionView.elementKindSectionHeader,
                          alignment: .topLeading)
                ]
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
        setBinding()
        setAttribute()
        setCell()
        trendingViewModel.fetchTrandingKeword()
        mostPopularViewModel.fetchMostPopular()
    }
    
    
    
    //MARK: - HelperFunction
    func setAttribute() {
        collectionView.backgroundColor = .black
    }
    func setCell() {
        collectionView.register(TrendingCell.self, forCellWithReuseIdentifier: TrendingCell.identifier)
        collectionView.register(MostPopularCell.self, forCellWithReuseIdentifier: MostPopularCell.identifier)
        collectionView.register(ListCellHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ListCellHeader.identifier)
    }
    func setBinding() {
        trendingViewModel.fetchSuccess.bind { [weak self] _ in
            self?.collectionView.reloadData()
        }
        trendingViewModel.serviceError.bind { error in
            print("Debug: 인기 키워드 \(error) ")
        }
        mostPopularViewModel.fetchSuccess.bind { [weak self] _ in
            self?.collectionView.reloadData()
        }
        mostPopularViewModel.serviceError.bind { error in
            print("Debug: 인기 GIF \(error)")
        }
    }

    //MARK: - DatSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return trendingViewModel.count
        case 1: return mostPopularViewModel.count
        default: return 0
        }
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendingCell.identifier, for: indexPath) as! TrendingCell
            cell.viewModel = trendingViewModel.itemAtIndex(indexPath.row)
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MostPopularCell.identifier, for: indexPath) as! MostPopularCell
            cell.viewModel = mostPopularViewModel.itemAtIndex(indexPath.row)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ListCellHeader.identifier, for: indexPath) as! ListCellHeader
        if kind == UICollectionView.elementKindSectionHeader {
            switch indexPath.section {
            case 0:
                header.label.text = "Trending Searches"
                return header
            case 1:
                header.label.text = "Most Popular Now"
                return header
            default:
                return UICollectionReusableView()
            }
        } else {
            return UICollectionReusableView()
        }
    }
    
}

