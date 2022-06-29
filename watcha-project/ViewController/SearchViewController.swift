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
        tf.placeholder = " Search GIPHY"
        tf.backgroundColor = .white
        tf.tintColor = .darkGray
        return tf
    }()
    private let searchButton: UIButton = {
        let bt = UIButton(type: .system)
        bt.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        bt.tintColor = .white
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemPink.cgColor,UIColor.systemPurple.cgColor]
        gradient.locations = [0,1]
        gradient.startPoint = CGPoint(x: 1.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        bt.layer.insertSublayer(gradient, at: 0)
        if let imageView = bt.imageView {
            bt.bringSubviewToFront(imageView)
        }
        return bt
    }()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setAttribute()
        setNavigation()
    }
    
    //MARK: - HelperFunction
    
    private func setAttribute() {
        view.backgroundColor = .black
    }
    private func setNavigation() {
        navigationController?.navigationBar.isHidden = true
    }
    private func setLayout() {
        [searchTextField].forEach {
            view.addSubview($0)
        }
        searchTextField.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.leadingAnchor,
            trailing: searchButton.leadingAnchor,
            height: 50
        )
    }
}
