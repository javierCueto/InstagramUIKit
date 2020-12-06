//
//  SearchController.swift
//  InstagramUIKit
//
//  Created by Javier Cueto on 23/11/20.
//

import UIKit
private let reuserIdentifier = "UserCell"


class SearchController: UITableViewController{
    // MARK: -  PROPERTIES
    private var users = [User]()
    
    // MARK: -  LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        fetchUsers()
    }
    
    // MARK: -  HELPERS
    
    func configureTableView(){
        tableView.register(UserCell.self, forCellReuseIdentifier: reuserIdentifier)
        
        tableView.rowHeight = 64
    }
    
    // MARK: -  API
    
    func fetchUsers(){
        UserService.fetchUsers { (users) in
            self.users = users
            self.tableView.reloadData()
        }
    }
    
    
}


// MARK: -  UITableViewDataSource
extension SearchController {
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuserIdentifier, for: indexPath) as! UserCell
        
        cell.user = users[indexPath.row]
        return cell
    }
}
