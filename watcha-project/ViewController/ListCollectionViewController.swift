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
                return NSCollectionLayoutSection(
                   group: NSCollectionLayoutGroup(
                       layoutSize: NSCollectionLayoutSize(
                           widthDimension: .absolute(0), heightDimension: .absolute(0)
                       )
                   )
                )
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
    }

    //MARK: - DatSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "", for: indexPath)
        return cell
    }
}
