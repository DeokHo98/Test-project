//
//  ListCollectionViewController.swift
//  watcha-project
//
//  Created by 정덕호 on 2022/06/29.
//

import UIKit

class ListCollectionViewController: UICollectionViewController {

    //MARK: - Property
    var trendingViewModel: KeywordViewModel = KeywordViewModel()
    var mostPopularViewModel: GIFViewModelList = GIFViewModelList()
    
    //MARK: - lifeCycle
    
    init() {
        super.init(collectionViewLayout: UICollectionViewCompositionalLayout.setCompositionalLayout())
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
   private func setAttribute() {
        collectionView.backgroundColor = .black
    }
    private func setCell() {
        collectionView.register(TrendingCell.self, forCellWithReuseIdentifier: TrendingCell.identifier)
        collectionView.register(MostPopularCell.self, forCellWithReuseIdentifier: MostPopularCell.identifier)
        collectionView.register(ListCellHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ListCellHeader.identifier)
    }
    private func setBinding() {
        trendingViewModel.fetchSuccess.bind { [weak self] _ in
            self?.collectionView.reloadSections(IndexSet(0...0))
        }
        trendingViewModel.serviceError.bind { error in
            print("Debug: 인기 키워드 \(error) ")
        }
        mostPopularViewModel.fetchSuccess.bind { [weak self] _ in
            self?.collectionView.reloadSections(IndexSet(1...1))
        }
        mostPopularViewModel.serviceError.bind { error in
            print("Debug: 인기 GIF \(error)")
        }
    }

    
    //MARK: - CollectionViewxDatSource

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
    
    // MARK: - CollectionViewDelegate

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
            if scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.bounds.height - 300 {
                if !mostPopularViewModel.pagingStart {
                    mostPopularViewModel.pagingStart = true
                    mostPopularViewModel.nextPageFetch()
                }
            }
        }
    
}

