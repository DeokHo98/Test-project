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
    private let autocompleteTableView: UITableViewController = AutocompleteTableViewController()
    private var showAutocompleteTableViewState: Bool = false
    private let listCollectionView: UICollectionViewController = ListCollectionViewController()
    
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
        searchTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    private func setNavigation() {
        navigationController?.navigationBar.isHidden = true
    }
    private func setLayout() {
        [searchButton,searchTextField,listCollectionView.view].forEach {
            view.addSubview($0)
        }
        searchButton.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            trailing: view.trailingAnchor,
            width: 50,
            height: 50
        )
        searchTextField.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.leadingAnchor,
            trailing: searchButton.leadingAnchor,
            height: 50
        )
        listCollectionView.view.anchor(
            top: searchTextField.bottomAnchor,
            leading: view.leadingAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            trailing: view.trailingAnchor
        )
    }
    private func showAutocompleteTableView() {
        if !showAutocompleteTableViewState {
            view.addSubview(autocompleteTableView.view)
            autocompleteTableView.view.anchor(top: searchTextField.bottomAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
            showAutocompleteTableViewState = true
        }
    }
    private func offShowAutocompleteTableView() {
        if searchTextField.text == "" {
            autocompleteTableView.view.removeFromSuperview()
            showAutocompleteTableViewState = false
        }
    }
    @objc private func textFieldDidChange() {
        showAutocompleteTableView()
        offShowAutocompleteTableView()
    }
}

