//
//  AuthService.swift
//  InstagramUIKit
//
//  Created by Javier Cueto on 28/11/20.
//

import UIKit
import Firebase

struct AuthCredentials {
    let email: String
    let password: String
    let fullname: String
    let username: String
    let profileImage: UIImage
    
}

struct AuthService {
    
    static func logUserIn(with email: String, password: String, completion: AuthDataResultCallback?){
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    static func registerUser(withCredential credentials: AuthCredentials, completion: @escaping(Error?) -> Void){
        ImageUploader.uploadImage(image: credentials.profileImage) { (urlImage) in
            Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { (result, error) in
                if let error = error {
                    myPrint("Failed to register user \(error.localizedDescription)")
                    return
                }
                
                guard let uid = result?.user.uid else {return}
                
                let data: [String: Any] = ["email": credentials.email, "fullname": credentials.fullname, "profileImageUrl": urlImage, "uid": uid, "username": credentials.username]
                
                COLLECTION_USERS.document(uid).setData(data, completion: completion)
                
            }
        }
    }
    
    
}
