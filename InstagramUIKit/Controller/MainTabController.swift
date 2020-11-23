//
//  MainTabController.swift
//  InstagramUIKit
//
//  Created by Javier Cueto on 23/11/20.
//

import UIKit

class MainTabController: UITabBarController {
    
    // MARK: -  LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllers()
    }
    
    // MARK: -  HELPERS
    func configureViewControllers(){
        view.backgroundColor = .white
        let feed = FeedController()
        let search = SearchController()
        let imageSelector = ImageSelectorController()
        let notification = NotificationController()
        let profile = ProfileController()
        
        viewControllers = [feed,search,imageSelector,notification, profile]
    }
}
