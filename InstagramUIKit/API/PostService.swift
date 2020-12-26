//
//  PostService.swift
//  InstagramUIKit
//
//  Created by Javier Cueto on 26/12/20.
//

import UIKit
import Firebase

struct PostService {
    static func uploadPost(caption: String, image: UIImage, completion: @escaping(FirestoreCompletion)){
        guard let uid = Auth.auth().currentUser?.uid else  {return}
        
        ImageUploader.uploadImage(image: image) { (imageURL) in
            let data = [
                "caption": caption,
                "timestamp": Timestamp(date: Date()),
                "likes" : 0,
                "imageUrl": imageURL,
            "ownerUid": uid] as [String : Any]
            
            COLLECTION_POST.addDocument(data: data, completion: completion)
        }
    }
}
