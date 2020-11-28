//
//  ImageUploader.swift
//  InstagramUIKit
//
//  Created by Javier Cueto on 28/11/20.
//

import Firebase


struct ImageUploader {
    static func uploadImage(image: UIImage, completion: @escaping(String) -> Void){
        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
        let filename = NSUUID().uuidString
        
        let ref = Storage.storage().reference(withPath: "/profile_images/\(filename)")
        
        ref.putData(imageData, metadata: nil) { (metadata, error) in
            if let error = error {
                myPrint("Failed to upload image \(error.localizedDescription)")
                return
            }
            
            ref.downloadURL { (url, error) in
                guard let imageUrl = url?.absoluteString else {return}
                completion(imageUrl)
            }
        }
    }
}
