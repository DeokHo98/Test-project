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
    }
    
}
