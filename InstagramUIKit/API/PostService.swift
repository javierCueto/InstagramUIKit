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
        COLLECTION_POST.getDocuments { (snapshop, error) in
            guard let documents = snapshop?.documents else {return}
            
            let posts = documents.map{( Post(postId: $0.documentID, dictionary: $0.data()) )}
            
            completion(posts)
        }
    }
}
