//
//  MostCell.swift
//  watcha-project
//
//  Created by 정덕호 on 2022/06/29.
//
import UIKit

class MostPopularCell: UICollectionViewCell {
    
    //MARK: - Identifier
    
    static let identifier = "MostPopularCell"
    
    //MARK: - Property
    
    var viewModel: GIFViewModelItem? {
        didSet {
            setViewModel()
        }
    }
    private let imageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
 
    //MARK: -  lifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        setViewModel()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - HelperFunction
    
    private func setLayout() {
        self.addSubview(imageView)
        imageView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor)
    }
    private func setViewModel() {
        guard let viewModel = viewModel else {return}
        ImageLoader.fetchImage(url: viewModel.imageURL) { [weak self] image in
            self?.imageView.image = image
        }
    }
}
