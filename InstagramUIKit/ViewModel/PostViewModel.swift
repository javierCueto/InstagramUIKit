//
//  PostViewModel.swift
//  InstagramUIKit
//
//  Created by Javier Cueto on 26/12/20.
//

import UIKit

struct PostViewModel {
    var post: Post
    
    var imageUrl: URL?{
        return URL(string: post.imageUrl)
    }
    
    var likeButtonTintColor: UIColor {
        if post.didlike {
            return .red
        }else{
            return .black
        }
    }
    
    var likeButtonImage: UIImage? {
        let image = post.didlike ? "like_selected" : "like_unselected"
        return UIImage(named: image)
    }
    
    var caption: String {
        return post.caption
    }
    
  
    var likes: Int {
        return post.likes
    }
    
    var likesLabelText: String {
        if post.likes != 1 {
            return "\(post.likes) likes"
        }else{
            return "\(post.likes) like"
        }
    }
    
    var ownerImageUrl: URL?{
        return URL(string: post.ownerImageUrl)
    }
    
    var ownerUsername: String {
        return post.ownerUsername
    }
    /*let ownerUid: String
    let timestamp: Timestamp
    let postID: String*/
    
    
    var timestampString: String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .full
        return formatter.string(from: post.timestamp.dateValue(), to: Date())
    }
    
    init(post: Post) {
        self.post = post
    }
}
