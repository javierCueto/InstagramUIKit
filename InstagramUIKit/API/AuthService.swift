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
    static func registerUser(withCredential credentials: AuthCredentials){
        myPrint("Credentials are \(credentials)")
    }
}
