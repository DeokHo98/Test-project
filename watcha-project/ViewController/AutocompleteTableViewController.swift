//
//  autocompleteTableViewController.swift
//  watcha-project
//
//  Created by 정덕호 on 2022/06/30.
//

import UIKit

class AutocompleteTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAttribute()
    }

    //MARK: - helperFunction
    
    private func setAttribute() {
        tableView.backgroundColor = .black
        tableView.register(AutocompleteCell.self, forCellReuseIdentifier: AutocompleteCell.identifier)
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AutocompleteCell.identifier, for: indexPath) as! AutocompleteCell
        return cell
    }

}
