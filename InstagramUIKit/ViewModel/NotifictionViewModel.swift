//
//  NotifictionViewModel.swift
//  InstagramUIKit
//
//  Created by Javier Cueto on 17/01/21.
//

import UIKit

struct NotificationViewModel {
    var notification: Notification
    
    init(notification: Notification){
        self.notification = notification
    }
    
    var postImageUrl: URL? { return URL(string: notification.postImageUrl ?? "" )}
    
    var profileImageUrl: URL? { return URL(string: notification.userProfileImageUrl )}
    
    var notificationMessage: NSAttributedString{
        let username = notification.username
        let message = notification.type.notificationMessage
        
        let attributedString = NSMutableAttributedString(string: "\(username)", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedString.append(NSMutableAttributedString(string: message, attributes: [.font: UIFont.systemFont(ofSize: 14)]))
        
        attributedString.append(NSMutableAttributedString(string: " 2m", attributes: [.font: UIFont.systemFont(ofSize: 12), .foregroundColor: UIColor.lightGray]))
        
        return attributedString
        
    }
    
    var shouldHidePostImage: Bool {
        return self.notification.type == .follow
    }
    
    var folloeButtonText: String {
        return notification.userIsFollowed ? "Following" : "Follow"
    }
    
    var followButtonBackgroundColor: UIColor {
        return notification.userIsFollowed ? .white : .systemBlue
    }
    
    var followButtonTextColor: UIColor {
        return notification.userIsFollowed ? .black : .white
    }
}
