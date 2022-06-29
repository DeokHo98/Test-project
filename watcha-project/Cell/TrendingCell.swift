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
    
    //MARK: -  lifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
