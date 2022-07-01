//
//  SearchResultCollectionViewController.swift
//  watcha-project
//
//  Created by 정덕호 on 2022/06/30.
//

import UIKit

class SearchResultCollectionViewController: UICollectionViewController {

    //MARK: - Property
    var text: String? {
        didSet {
            viewModel.fetchMostGIF(text: text ?? "")
        }
    }
     let viewModel: GIFViewModelList = GIFViewModelList()
    
    //MARK: - lifeCycle
    
    init() {
        super.init(collectionViewLayout: UICollectionViewCompositionalLayout.searchResultCollectionViewLayout())
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setBinding()
        setAttribute()
        setCell()
        setNavigation()
    }
    
    //MARK: - HelperFunction
   private func setAttribute() {
        collectionView.backgroundColor = .black
    }
    private func setCell() {
        collectionView.register(GIFCell.self, forCellWithReuseIdentifier: GIFCell.identifier)
        collectionView.register(ListCellHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ListCellHeader.identifier)
    }
    private func setNavigation() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.tintColor = .systemBlue
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.backgroundColor = .black
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.title = text
    }
    private func setBinding() {
        viewModel.fetchSuccess.bind { [weak self] _ in
            self?.collectionView.reloadData()
        }
        viewModel.serviceError.bind { error in
            print("Debug: 검색 GIF \(error)")
        }
    }

    
    //MARK: - CollectionViewxDatSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GIFCell.identifier, for: indexPath) as! GIFCell
        cell.viewModel = viewModel.itemAtIndex(indexPath.row)
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ListCellHeader.identifier, for: indexPath) as! ListCellHeader
        if kind == UICollectionView.elementKindSectionHeader {
            header.label.text = "All the GIFs"
            return header
        } else {
            return UICollectionReusableView()
        }
    }
    
    // MARK: - CollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.cellOffSet.value = indexPath.row
        let vc = DetailCollectionViewController(viewModel: viewModel)
        navigationController?.pushViewController(vc, animated: true)
    }
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.bounds.height - (view.bounds.height / 4) {
            if !viewModel.pagingStart {
                viewModel.pagingStart = true
                viewModel.nextPageFetch(text: text ?? "")
            }
        }
    }
}
