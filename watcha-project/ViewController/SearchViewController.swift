//
//  MainViewController.swift
//  watcha-project
//
//  Created by 정덕호 on 2022/06/29.
//

import UIKit

class SearchViewController: UIViewController {
    
    //MARK: - Property
    
    private let searchTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Search GIPHY"
        tf.backgroundColor = .white
        tf.tintColor = .darkGray
        return tf
    }()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
    }
    
    //MARK: - HelperFunction
    private func setAttribute() {
        view.backgroundColor = .black
    }
    private func setLayout() {
        [searchTextField].forEach {
            view.addSubview($0)
        }
        searchTextField.anchor(top: view.safeAreaLayoutGuide.topAnchor,leading: view.leadingAnchor,trailing: view.trailingAnchor,height: 50)
    }
}
