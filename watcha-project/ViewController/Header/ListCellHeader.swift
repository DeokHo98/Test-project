//
//  ListHeader.swift
//  watcha-project
//
//  Created by 정덕호 on 2022/06/29.
//

import UIKit

class ListCellHeader: UICollectionReusableView {
    
    //MARK: - Identifier
    
    static let identifier = "ListCellHeader"
    
    //MARK: - Property
    
    let label: UILabel = {
        let lb = UILabel()
        lb.textColor = .systemGray5
        lb.font = .boldSystemFont(ofSize: 18)
        return lb
    }()
    
    //MARK: - lifeCycle
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - HelperFunction
    
    private func setLayout() {
        self.addSubview(label)
        label.centerY(inView: self)
        label.anchor(leading: self.leadingAnchor, paddingLeading: 10)
    }
    
}
