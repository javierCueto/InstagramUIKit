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
    
    // MARK: -  LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    // MARK: -  HELPERS
    
    func configureTableView(){
        tableView.register(UserCell.self, forCellReuseIdentifier: reuserIdentifier)
        
        tableView.rowHeight = 64
    }
    
    
}


// MARK: -  UITableViewDataSource
extension SearchController {
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuserIdentifier, for: indexPath)
        return cell
    }
}
