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
    private let searchController = UISearchController(searchResultsController: nil)
    private var filterUser = [User]()
    
    private var inSearchMode: Bool{
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
    }
    
    // MARK: -  LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        configureTableView()
        fetchUsers()
       
    }
    
    // MARK: -  HELPERS
    
    func configureTableView(){
        tableView.register(UserCell.self, forCellReuseIdentifier: reuserIdentifier)
        tableView.rowHeight = 64
    }
    
    func configureSearchController(){
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = false
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
        return inSearchMode ? filterUser.count : users.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuserIdentifier, for: indexPath) as! UserCell
        if inSearchMode {
            cell.viewModel = UserCellViewModel(user: filterUser[indexPath.row])
        }else {
            cell.viewModel = UserCellViewModel(user: users[indexPath.row])
        }
       
        return cell
    }
}


// MARK: -  UITableDelegate
extension SearchController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let user = inSearchMode ? filterUser[indexPath.row] : users[indexPath.row]
        let controller = ProfileController(user: user)
        navigationController?.pushViewController(controller, animated: true)
        
    }
}

extension SearchController : UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else {return}
        
        filterUser = users.filter({
            $0.username.contains(searchText) || $0.fullname.lowercased().contains(searchText)
        })
        self.tableView.reloadData()
    }
    
    
}
