//
//  PostViewModel.swift
//  InstagramUIKit
//
//  Created by Javier Cueto on 26/12/20.
//

import Foundation

struct PostViewModel {
     let post: Post
    
    var imageUrl: URL?{
        return URL(string: post.imageUrl)
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
    
    
    init(post: Post) {
        self.post = post
    }
}
