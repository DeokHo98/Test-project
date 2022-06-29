//
//  TrendingCell.swift
//  watcha-project
//
//  Created by 정덕호 on 2022/06/29.
//

import UIKit

class TrendingCell: UICollectionViewCell {
    
    //MARK: - Identifier
    
    static let identifier = "TrendingCell"
    
    //MARK: - Property
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "arrow.up.right")
        iv.tintColor = .systemBlue
        return iv
    }()
    private let keywordLabel: UILabel = {
        let lb = UILabel()
        lb.font = .boldSystemFont(ofSize: 20)
        lb.textColor = .white
        lb.text = "reoobtasd"
        return lb
    }()
    
    //MARK: -  lifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - HelperFunction
    
    private func setLayout() {
        [imageView, keywordLabel].forEach {
            addSubview($0)
        }
        imageView.centerY(inView: self)
        imageView.anchor(leading: self.leadingAnchor, paddingLeading: 10, width: 23, height: 23)
        keywordLabel.centerY(inView: self)
        keywordLabel.anchor(leading: imageView.trailingAnchor, trailing: self.trailingAnchor, paddingLeading: 10, paddingTrailing: 10)
    }
    
}