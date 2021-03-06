//
//  ListCollectionViewController.swift
//  watcha-project
//
//  Created by 정덕호 on 2022/06/29.
//

import UIKit

class ListCollectionViewController: UICollectionViewController {

    //MARK: - Property
    var trendingViewModel: KeywordViewModelList = KeywordViewModelList()
    var mostPopularViewModel: GIFViewModelList = GIFViewModelList()
    weak var delegate: keyWordDelegate?
    
    //MARK: - lifeCycle
    
    init() {
        super.init(collectionViewLayout: UICollectionViewCompositionalLayout.ListCollectionViewLayout())
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
        mostPopularViewModel.fetchMostGIF()
    }
    
    //MARK: - HelperFunction
   private func setAttribute() {
        collectionView.backgroundColor = .black
    }
    private func setCell() {
        collectionView.register(KeywordCell.self, forCellWithReuseIdentifier: KeywordCell.identifier)
        collectionView.register(GIFCell.self, forCellWithReuseIdentifier: GIFCell.identifier)
        collectionView.register(ListCellHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ListCellHeader.identifier)
    }
    private func setBinding() {
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KeywordCell.identifier, for: indexPath) as! KeywordCell
            cell.viewModel = trendingViewModel.itemAtIndex(indexPath.row)
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GIFCell.identifier, for: indexPath) as! GIFCell
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
        delegate?.scrollCollectionView()
        if scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.bounds.height - (view.bounds.height / 4) {
                if !mostPopularViewModel.pagingStart {
                    mostPopularViewModel.pagingStart = true
                    mostPopularViewModel.nextPageFetch()
                }
            }
        }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            delegate?.didSelectRowAt(keyword: trendingViewModel.itemAtIndex(indexPath.row).searchKeyword)
        case 1:
            mostPopularViewModel.cellOffSet.value = indexPath.row
            delegate?.didSelectRowAt(viewModel: mostPopularViewModel)
        default:
            break
        }
    }
    
}

