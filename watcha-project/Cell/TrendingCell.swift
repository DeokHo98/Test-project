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
        iv.backgroundColor = .clear
        return iv
    }()
    
    //MARK: -  lifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
