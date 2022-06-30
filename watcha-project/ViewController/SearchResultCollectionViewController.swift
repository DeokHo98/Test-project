//
//  SearchResultCollectionViewController.swift
//  watcha-project
//
//  Created by 정덕호 on 2022/06/30.
//

import UIKit

class SearchResultCollectionViewController: UICollectionViewController {

    //MARK: - Property
    
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
    }
    private func setBinding() {
     
    }

    
    //MARK: - CollectionViewxDatSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return 100
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GIFCell.identifier, for: indexPath) as! GIFCell
        cell.backgroundColor = .red
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
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.bounds.height - 300 {
        }
    }
}
