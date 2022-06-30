//
//  AutocompleteCell.swift
//  watcha-project
//
//  Created by 정덕호 on 2022/06/30.
//
import UIKit

class AutocompleteCell: UITableViewCell {
  
    //MARK: - Identifier
    
    static let identifier = "AutocompleteCell"
    
    //MARK: - Property
    
    var viewModel: AutocompleteViewModelItem? {
        didSet {
            setViewModel()
        }
    }
    
    private let autoimageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "magnifyingglass")
        iv.tintColor = .white
        return iv
    }()
    
    private let label: UILabel = {
        let lb = UILabel()
        lb.text = "12312312312"
        lb.textColor = .white
        lb.font = .boldSystemFont(ofSize: 18)
        return lb
    }()
    
    //MARK: - lifeCycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
        setAttribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     //MARK: - helperFunction
    
    private func setLayout() {
        [autoimageView, label].forEach {
            self.addSubview($0)
        }
        autoimageView.centerY(inView: self)
        autoimageView.anchor(leading: self.leadingAnchor, paddingLeading: 10, width: 23, height: 23)
        label.centerY(inView: self)
        label.anchor(leading: autoimageView.trailingAnchor, trailing: self.trailingAnchor, paddingLeading: 10, paddingTrailing: 10)
    }
    private func setAttribute() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
    }
    private func setViewModel() {
        self.label.text = viewModel?.keyword
    }
    
    
}


