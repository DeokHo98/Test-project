//
//  DtailCellHeader.swift
//  watcha-project
//
//  Created by 정덕호 on 2022/06/30.
//

import UIKit

class DetailCellfooter: UICollectionReusableView {
    
    //MARK: - Identifier
    
    static let identifier = "DetailCellHeader"
    
    //MARK: - Property
    
    var viewModel: GIFViewModelItem? {
        didSet {
            setViewModel()
        }
    }
    private let profileImage: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .gray
        iv.image = UIImage(systemName: "person")
        iv.tintColor = .black
        return iv
    }()
    private let namelabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .white
        lb.font = .boldSystemFont(ofSize: 18)
        return lb
    }()
    private let emailLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .lightGray
        lb.font = .boldSystemFont(ofSize: 15)
        return lb
    }()
    private let favoriteButton: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "heart.fill")
        iv.tintColor = .white
        return iv
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
        [profileImage, namelabel, emailLabel, favoriteButton].forEach {
            self.addSubview($0)
        }
        profileImage.centerY(inView: self)
        profileImage.anchor(leading: self.leadingAnchor, paddingLeading: 20, width: 50, height: 50)
        namelabel.anchor(top: profileImage.topAnchor, leading: profileImage.trailingAnchor, paddingTop: 5, paddingLeading: 10)
        emailLabel.anchor(leading: profileImage.trailingAnchor, bottom: profileImage.bottomAnchor, paddingLeading: 10, paddingBottom: 5)
        favoriteButton.centerY(inView: self)
        favoriteButton.anchor(trailing: self.trailingAnchor, paddingTrailing: 20, width: 35, height: 35)
    }
    private func setViewModel() {
        guard let viewModel = viewModel else {
            return
        }
        profileImage.image = nil
        namelabel.text = viewModel.userName
        emailLabel.text = viewModel.email
        ImageLoader.fetchImage(url: viewModel.userProfileImage) { [weak self] image in
            self?.profileImage.image = image
        }
    }
    
}

