//
//  User.swift
//  InstagramUIKit
//
//  Created by Javier Cueto on 03/12/20.
//

import Foundation
import Firebase
struct User {
    let email: String
    let fullname: String
    let profileImageUrl: String
    let username: String
    let uid: String
    
    var isFollowed = false
    
    var stats: UserStats!
    
    var isCurrentUser: Bool {return Auth.auth().currentUser?.uid == uid}
    
    init(dictionary: [String: Any]){
        self.uid = dictionary["uid"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.stats = UserStats(follower: 0, following: 0, post: 0)
    }
}


struct UserStats {
    let follower: Int
    let following: Int
    let post: Int
}
