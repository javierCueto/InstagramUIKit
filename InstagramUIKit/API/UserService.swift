//
//  UserService.swift
//  InstagramUIKit
//
//  Created by Javier Cueto on 03/12/20.
//

import Firebase

struct UserService {
    static func fetchUser(completion: @escaping(User) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        COLLECTION_USERS.document(uid).getDocument{ (snapshot, error) in
            if let error = error {
                myPrint("\(error.localizedDescription)")
            }
            guard let dictionary : [String : Any] = snapshot?.data() else {return}
            let user = User(dictionary: dictionary)
            completion(user)
        }
    }
}