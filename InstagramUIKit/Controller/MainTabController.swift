//
//  MainTabController.swift
//  InstagramUIKit
//
//  Created by Javier Cueto on 23/11/20.
//

import UIKit
import Firebase
import YPImagePicker

class MainTabController: UITabBarController {
    // MARK: -  PROPERTIES
    private var user: User? {
        didSet{
            guard let user = user else {return}
            configureViewControllers(withUser: user)
        }
    }
    
    // MARK: -  LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        //configureViewControllers()
        view.backgroundColor = .white
        myPrint("entro al viewDidload")
        fecthUser()
    }
    
    // MARK: -  API
    
    func fecthUser(){
        UserService.fetchUser { (user) in
            self.user = user
        }
    }
    
    // MARK: -  HELPERS
    func configureViewControllers(withUser user:User){
        view.backgroundColor = .white
        self.delegate = self
        
        let layout = UICollectionViewFlowLayout()
        let feed = templateNavigationController(unseledtedImage: #imageLiteral(resourceName: "home_unselected"), selectedImage: #imageLiteral(resourceName: "home_selected"), rootViewController: FeedController(collectionViewLayout: layout))
        
        let search = templateNavigationController(unseledtedImage: #imageLiteral(resourceName: "search_unselected"), selectedImage: #imageLiteral(resourceName: "search_selected"), rootViewController: SearchController())
        
        let imageSelector = templateNavigationController(unseledtedImage: #imageLiteral(resourceName: "plus_unselected"), selectedImage: #imageLiteral(resourceName: "plus_unselected"), rootViewController: ImageSelectorController())
        
        let notification = templateNavigationController(unseledtedImage: #imageLiteral(resourceName: "like_unselected"), selectedImage: #imageLiteral(resourceName: "like_selected"), rootViewController: NotificationController())

        
        let profile = templateNavigationController(unseledtedImage: #imageLiteral(resourceName: "profile_unselected"), selectedImage: #imageLiteral(resourceName: "profile_selected"), rootViewController: ProfileController(user: user))
        
        viewControllers = [feed,search,imageSelector,notification, profile]
        tabBar.tintColor = .black
    }
    
    func templateNavigationController(unseledtedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController) -> UINavigationController{
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = unseledtedImage
        nav.tabBarItem.selectedImage = selectedImage
        nav.navigationBar.tintColor = .black
        return nav
    }
    
    func didFinishPickingMedia(_ picker: YPImagePicker){
        picker.didFinishPicking { (items, _) in
            picker.dismiss(animated: true) {
                guard let selectedImage = items.singlePhoto?.image else {return}
                myPrint("selected image")
            }
        }
    }
}

// MARK: -  AUTHENTICATION DELEGATE
extension MainTabController: AuthenticationDelegate{
    func auntenticationDidComplete() {
        fecthUser()
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: -  UITABBARCONTROLLERDELEGATE
extension MainTabController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        //return false
        let index = viewControllers?.firstIndex(of: viewController)
        
        if index == 2 {
            var config = YPImagePickerConfiguration()
            config.library.mediaType = .photo
            config.shouldSaveNewPicturesToAlbum = true
            config.startOnScreen = .library
            config.screens = [.library]
            config.hidesStatusBar = false
            config.hidesBottomBar = false
            config.library.maxNumberOfItems = 1
            
            let picker = YPImagePicker(configuration: config)
            picker.modalPresentationStyle = .fullScreen
            present(picker, animated: true, completion: nil)
            
            didFinishPickingMedia(picker)
            //tabBarController.selectedIndex = 2
            return false
        }
        
        return true
    }
}
