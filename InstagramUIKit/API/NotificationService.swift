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
        
        
        let docRef = COLLECTION_NOTIFICATIONS.document(uid).collection("user-notifications").document()
        
        var data: [String: Any] = ["timestamp" : Timestamp(date: Date()), "uid": currentUid, "type" : type.rawValue, "id": docRef.documentID]
  
        if let post = post {
            data["postId"] = post.postID
            data["postImageUrl"] = post.imageUrl
        }
        
        docRef.setData(data)
        
    }
    
    static func fetchNotification(){
        
    }
}
