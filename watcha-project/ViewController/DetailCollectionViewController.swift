//
//  DetailCollectionViewController.swift
//  watcha-project
//
//  Created by 정덕호 on 2022/06/30.
//

import UIKit

class DetailCollectionViewController: UICollectionViewController {
    

    //MARK: - Property
    var GIFViewModel: GIFViewModelList
   private lazy var layout = UICollectionViewCompositionalLayout { section, env in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10)
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.9),
                heightDimension: .fractionalHeight(0.4)
            )
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitems: [item]
            )
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .none
            section.boundarySupplementaryItems = [
                .init(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                        heightDimension: .estimated(100)),
                      elementKind: UICollectionView.elementKindSectionFooter,
                      alignment: .bottom)
            ]
            section.contentInsets.bottom = 10
            section.orthogonalScrollingBehavior = .groupPagingCentered
            section.visibleItemsInvalidationHandler = { [weak self] (items, offset, env) -> Void in
                let page = round(offset.x / self!.view.bounds.width)
                self?.GIFViewModel.cellOffSet.value = Int(page)
            }
            return section
    }
    
    //MARK: - lifeCycle
    
    init(viewModel: GIFViewModelList) {
        self.GIFViewModel = viewModel
        super.init(collectionViewLayout: UICollectionViewLayout())
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setAttribute()
        setCell()
        setNavigation()
        setCollectionView()
    }
    
    //MARK: - HelperFunction
   private func setAttribute() {
        collectionView.backgroundColor = .black
    }
    private func setNavigation() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.tintColor = .systemBlue
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
    private func setCell() {
        collectionView.register(GIFCell.self, forCellWithReuseIdentifier: GIFCell.identifier)
        collectionView.register(DetailCellfooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: DetailCellfooter.identifier)
    }
    private func setCollectionView() {
        collectionView.collectionViewLayout = layout
        collectionView.scrollToItem(at: NSIndexPath(item: GIFViewModel.cellOffSet.value, section: 0) as IndexPath, at: .right, animated: false)
    }
  
    //MARK: - CollectionViewxDatSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return GIFViewModel.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GIFCell.identifier, for: indexPath) as! GIFCell
            cell.viewModel = GIFViewModel.itemAtIndex(indexPath.row)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DetailCellfooter.identifier, for: indexPath) as! DetailCellfooter
            GIFViewModel.cellOffSet.bind { [weak self] offset in
                footer.GIFViewModel = self?.GIFViewModel.itemAtIndex(offset)
            }
            return footer
        }
        return UICollectionReusableView()
    }
  
    
    // MARK: - CollectionViewDelegate
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.bounds.height - (view.bounds.height / 4) {
        }
    }
}
