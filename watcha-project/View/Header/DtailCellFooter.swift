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
    
    var GIFViewModel: GIFViewModelItem? {
        didSet {
            setViewModel()
        }
    }
    var favoriteViewModel: FavoriteViewModel = FavoriteViewModel()
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
    private lazy var favoriteButton: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "heart.fill")
        iv.tintColor = .white
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(favoriteButtonTapped))
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(tapGestureRecognizer)
        return iv
    }()
    
    //MARK: - lifeCycle
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        setBinding()
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
        guard let viewModel = GIFViewModel else {
            return
        }
        favoriteViewModel.fetch()
        profileImage.image = nil
        namelabel.text = viewModel.userName
        emailLabel.text = viewModel.email
        ImageLoader.fetchImage(url: viewModel.userProfileImage) { [weak self] image in
            self?.profileImage.image = image
        }
    }
    @objc private func favoriteButtonTapped() {
        if favoriteViewModel.validLikeState.value {
            favoriteViewModel.fetch()
            favoriteViewModel.unlike(id: GIFViewModel?.id ?? "")
        } else {
            favoriteViewModel.like(id: GIFViewModel?.id ?? "")
        }
    }
    private func setBinding() {
        favoriteViewModel.serviceError.bind { error in
            print("debug: 코어데이터 에러")
        }
        favoriteViewModel.fetchSuccess.bind { [weak self] _ in
            self?.favoriteViewModel.validLikeState(id: self?.GIFViewModel?.id ?? "")
        }
        favoriteViewModel.validLikeState.bind { [weak self] bool in
            if bool {
                self?.favoriteButton.tintColor = .red
            } else {
                self?.favoriteButton.tintColor = .white
            }
        }
    }
}

