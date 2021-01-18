//
//  NotifictionViewModel.swift
//  InstagramUIKit
//
//  Created by Javier Cueto on 17/01/21.
//

import UIKit

struct NotificationViewModel {
    private let notification: Notification
    
    init(notification: Notification){
        self.notification = notification
    }
    
    var postImageUrl: URL? { return URL(string: notification.postImageUrl ?? "" )}
    
    var profileImageUrl: URL? { return URL(string: notification.userProfileImageUrl )}
    
    var ownerUser: String { return notification.username}
}
