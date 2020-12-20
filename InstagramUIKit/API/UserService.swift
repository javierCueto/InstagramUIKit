//
//  UserService.swift
//  InstagramUIKit
//
//  Created by Javier Cueto on 03/12/20.
//

import Firebase

typealias FirestoreCompletion = (Error?) -> Void

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
    
    
    static func fetchUsers(completion: @escaping( [User] ) -> Void){
        COLLECTION_USERS.getDocuments { (snapshot, error) in
            guard let snapshot = snapshot else { return }
            let users = snapshot.documents.map({ User(dictionary: $0.data()) })
            completion(users)
        }
    }
    
    static func follow(uid: String, completion: @escaping(FirestoreCompletion)){
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
        COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid).setData([:]) { (error) in
            
            COLLECTION_FOLLOWERS.document(uid).collection("user-followers").document(currentUid).setData([:] , completion: completion)
        }
    }
    
    static func unfollow(uid: String, completion: @escaping(FirestoreCompletion)){
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
        COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid).delete { (error) in
            
            COLLECTION_FOLLOWERS.document(uid).collection("user-followers").document(currentUid).delete( completion: completion)
        }
    }
}
