//
//  Comment.swift
//  InstagramUIKit
//
//  Created by Javier Cueto on 09/01/21.
//

import Firebase

struct Comment {
    var uid: String
    var username: String
    let profileImageUrl: String
    let timestamp: Timestamp
    let commentText: String
    
    init(dictionary: [String: Any]){
        self.uid = dictionary["uid"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        self.commentText = dictionary["comment"] as? String ?? ""
    }
    
}
