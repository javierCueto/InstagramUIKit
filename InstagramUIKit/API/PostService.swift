//
//  PostService.swift
//  InstagramUIKit
//
//  Created by Javier Cueto on 26/12/20.
//

import UIKit
import Firebase

struct PostService {
    static func uploadPost(caption: String, image: UIImage,user: User, completion: @escaping(FirestoreCompletion)){
        guard let uid = Auth.auth().currentUser?.uid else  {return}
        
        ImageUploader.uploadImage(image: image) { (imageURL) in
            let data = [
                "caption": caption,
                "timestamp": Timestamp(date: Date()),
                "likes" : 0,
                "imageUrl": imageURL,
                "ownerUid": uid,
                "ownerImageUrl": user.profileImageUrl,
                "ownerUsername": user.username
            ] as [String : Any]
            
            COLLECTION_POST.addDocument(data: data, completion: completion)
        }
    }
    
    static func fetchPost(completion: @escaping([Post]) -> Void){
        COLLECTION_POST.order(by: "timestamp",descending: true).getDocuments { (snapshot, error) in
            guard let documents = snapshot?.documents else {return}
            
            let posts = documents.map{( Post(postId: $0.documentID, dictionary: $0.data()) )}
            
            completion(posts)
        }
    }
    
    static func fetchPosts(forUser uid: String, completion: @escaping([Post]) -> Void){
        let query = COLLECTION_POST.whereField("ownerUid", isEqualTo: uid)//.order(by: "timestamp",descending: true)
        
        query.getDocuments { (snapshot, error) in
            guard let documents = snapshot?.documents else {return}
            
            var posts = documents.map{( Post(postId: $0.documentID, dictionary: $0.data()) )}
            
            posts.sort { (post1, post2) -> Bool in
                return post1.timestamp.seconds > post2.timestamp.seconds
            }
            
            
            completion(posts)
        }
    }
}
