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
        iv.backgroundColor = .white
        iv.tintColor = .systemBlue
        return iv
    }()
    
    //MARK: -  lifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        setLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - HelperFunction
    
    private func setLayout() {
        [imageView].forEach {
            addSubview($0)
        }
        imageView.centerY(inView: self)
        imageView.anchor(leading: self.leadingAnchor, paddingLeading: 10, width: 25, height: 25)
    }
    
}
