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
            
        
            
            let docRef = COLLECTION_POST.addDocument(data: data, completion: completion)
            
            self.updateUserFeedAfterPost(postId: docRef.documentID)
        }
    }
    
    static func fetchPosts(completion: @escaping([Post]) -> Void){
        COLLECTION_POST.order(by: "timestamp",descending: true).getDocuments { (snapshot, error) in
            guard let documents = snapshot?.documents else {return}
            let posts = documents.map{( Post(postId: $0.documentID, dictionary: $0.data()) )}
            completion(posts)
        }
    }
    
    static func fetchPost(withPostId postID: String, completion: @escaping(Post)-> Void){
        COLLECTION_POST.document(postID).getDocument { (snapshot, _) in
            guard let snapshot = snapshot else {return}
            guard let data = snapshot.data() else {return}
            let post = Post(postId: snapshot.documentID, dictionary: data)
            completion(post)
        }
    }
    
    static func fetchPosts(forUser uid: String, completion: @escaping([Post]) -> Void){
        let query = COLLECTION_POST.whereField("ownerUid", isEqualTo: uid)//.order(by: "timestamp",descending: true)
        
        query.getDocuments { (snapshot, error) in
            guard let documents = snapshot?.documents else {return}
            
            var posts = documents.map{( Post(postId: $0.documentID, dictionary: $0.data()) )}
            
            posts.sort(by: {$0.timestamp.seconds > $1.timestamp.seconds })
            
            
            completion(posts)
        }
    }
    
    static func likePost(post: Post, completion: @escaping(FirestoreCompletion)){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        COLLECTION_POST.document(post.postID).updateData(["likes": post.likes + 1])
        
        COLLECTION_POST.document(post.postID).collection("post-likes").document(uid).setData([:]) { (_) in
            COLLECTION_USERS.document(uid).collection("user-likes").document(post.postID).setData([:], completion: completion)
        }
    }
    
    static func unLikePost(post: Post, completion: @escaping(FirestoreCompletion)){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard post.likes > 0 else {return}
        
        COLLECTION_POST.document(post.postID).updateData(["likes": post.likes - 1])
        
        COLLECTION_POST.document(post.postID).collection("post-likes").document(uid).delete { (_) in
            COLLECTION_USERS.document(uid).collection("user-likes").document(post.postID).delete(completion: completion)
        }
    }
    
    static func checkIfUserLikedPost(post: Post, completion: @escaping(Bool) ->Void){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        COLLECTION_USERS.document(uid).collection("user-likes").document(post.postID).getDocument { (snapshot, error) in
            guard let didLike = snapshot?.exists else { return }
            
            completion(didLike)
        }
    }
    
    static func fetchFeedPost(completion: @escaping([Post])-> Void){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        var posts = [Post]()
        COLLECTION_USERS.document(uid).collection("user-feed").getDocuments { (snapshot, error) in
            snapshot?.documents.forEach({ (document) in
                fetchPost(withPostId: document.documentID) { (post) in
                    posts.append(post)
                    posts.sort(by: {$0.timestamp.seconds > $1.timestamp.seconds })
                    completion(posts)
                }
   
            })
     
        }
      
    }
    
    static func updateUserFeedAfterFollowing(user: User, didFollow: Bool){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let query = COLLECTION_POST.whereField("ownerUid", isEqualTo: user.uid)
        query.getDocuments { (snapshot, error) in
            guard let documents = snapshot?.documents else { return }
            
            let docIDs = documents.map({$0.documentID})
            
            docIDs.forEach { (id) in
                if didFollow{
                    COLLECTION_USERS.document(uid).collection("user-feed").document(id).setData([:])
                }else{
                    COLLECTION_USERS.document(uid).collection("user-feed").document(id).delete()
                }
                
            }
            
        }
    }
    
    private static func updateUserFeedAfterPost(postId: String){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        COLLECTION_FOLLOWERS.document(uid).collection("user-followers").getDocuments { (snapshot, error) in
            guard let documents = snapshot?.documents else { return }
            
            documents.forEach { (document) in
                COLLECTION_USERS.document(document.documentID).collection("user-feed").document(postId).setData([:])
            }
            
            COLLECTION_USERS.document(uid).collection("user-feed").document(postId).setData([:])
        }
    }
}
