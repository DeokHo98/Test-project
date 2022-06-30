//
//  autocompleteTableViewController.swift
//  watcha-project
//
//  Created by 정덕호 on 2022/06/30.
//

import UIKit

class AutocompleteTableViewController: UITableViewController {
    
    //MARK: - Property
    var text: String? {
        didSet {
            viewModel.fetchAutoCompleteKeyword(text: text ?? "")
        }
    }
    weak var delegate: keyWordDelegate?
    private var viewModel: AutocompleteViewModelList = AutocompleteViewModelList()
    
    //MARK: - lifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setAttribute()
        setBinding()
    }

    //MARK: - helperFunction
    
    private func setAttribute() {
        tableView.backgroundColor = .black
        tableView.register(AutocompleteCell.self, forCellReuseIdentifier: AutocompleteCell.identifier)
    }
    private func setBinding() {
        viewModel.fetchSuccess.bind { [weak self] _ in
            self?.tableView.reloadData()
        }
        viewModel.serviceError.bind { error in
            print("Debug: 자동완성키워드 \(error) ")
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AutocompleteCell.identifier, for: indexPath) as! AutocompleteCell
        cell.viewModel = viewModel.itemAtIndex(indexPath.row)
        return cell
    }
    
    //MARK: -  TableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectRowAt(keyword: viewModel.itemAtIndex(indexPath.row).searchKeyword)
    }

}
