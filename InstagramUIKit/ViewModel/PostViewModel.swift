//
//  PostViewModel.swift
//  InstagramUIKit
//
//  Created by Javier Cueto on 26/12/20.
//

import Foundation

struct PostViewModel {
    private let post: Post
    
    var imageUrl: URL?{
        return URL(string: post.imageUrl)
    }
    
    var caption: String {
        return post.caption
    }
    
  
    var likes: Int {
        return post.likes
    }
    /*let ownerUid: String
    let timestamp: Timestamp
    let postID: String*/
    
    
    init(post: Post) {
        self.post = post
    }
}
