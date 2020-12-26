//
//  ProfileHeaderViewModel.swift
//  InstagramUIKit
//
//  Created by Javier Cueto on 05/12/20.
//

import UIKit

struct ProfileHeaderViewModel{
    let user: User
    
    var fullname: String {
        return user.fullname
    }
    
    
    var profileImageUrl: URL? {
        return URL(string: user.profileImageUrl)
    }
    
    var followButtonText: String {
        if user.isCurrentUser {
            return "Edit Profile"
        }
        
        return user.isFollowed ? "Following" : "Follow"
    }
    
    var followButtonBackgroundColor: UIColor {
        return user.isCurrentUser ? .white : .systemBlue
    }
    
    var followButtonTextColor : UIColor {
        return user.isCurrentUser ? .black : .white
    }
    var numberOfFollowers: NSAttributedString {
        return atrributedStatText(value: user.stats.follower, label: "followers")
    }
    
    var numberOfFollowing: NSAttributedString {
        return atrributedStatText(value: user.stats.following, label: "following")
    }
    
    
    var numberOfPost: NSAttributedString {
        return atrributedStatText(value: user.stats.post, label: "post")
    }
    
    init(user: User){
        self.user = user
    }
    
    func atrributedStatText(value: Int, label: String) -> NSAttributedString{
        let attributedText = NSMutableAttributedString(string: "\(value)\n", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        
        attributedText.append(NSAttributedString(string: label, attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.lightGray]))
        
        return attributedText
    }
    
}
