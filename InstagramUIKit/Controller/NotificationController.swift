//
//  NotificationController.swift
//  InstagramUIKit
//
//  Created by Javier Cueto on 23/11/20.
//

import UIKit

private let reuseIdentifier = "NotificationCell"
class NotificationController: UITableViewController{
    // MARK: -  Properties
    private var notifications = [Notification](){
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: -  LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        fetchNotifications()
    }
    
    // MARK: - API
    func fetchNotifications(){
        NotificationService.fetchNotification { (notifications) in
            self.notifications = notifications
        }
    }
    
    // MARK: -  Helpers
    
    func configureTableView(){
        view.backgroundColor = .white
        navigationItem.title = "Notifications"
        tableView.register(NotificationCell.self, forCellReuseIdentifier: reuseIdentifier )
        tableView.rowHeight = 80
        tableView.separatorStyle = .none
    }
}

extension NotificationController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notifications.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! NotificationCell
        return cell
    }
}
