//
//  NotificationService.swift
//  InstagramUIKit
//
//  Created by Javier Cueto on 17/01/21.
//

import Firebase

struct NotificationService {
    static func uploadNotification(toUid uid: String, type: NotificationType, post: Post? = nil){
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        guard uid != currentUid else { return }
        var data: [String: Any] = ["timestamp" : Timestamp(date: Date()), "uid": currentUid, "type" : type.rawValue]
        
        if let post = post {
            data["postId"] = post.postID
            data["postImageUrl"] = post.imageUrl
        }
        
        COLLECTION_NOTIFICATIONS.document(uid).collection("user-notifications").addDocument(data: data)
        
    }
    
    static func fetchNotification(){
        
    }
}
