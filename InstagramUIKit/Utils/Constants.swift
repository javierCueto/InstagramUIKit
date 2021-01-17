//
//  Constants.swift
//  InstagramUIKit
//
//  Created by Javier Cueto on 03/12/20.
//

import Firebase


let COLLECTION_USERS = Firestore.firestore().collection("users")
let COLLECTION_FOLLOWERS = Firestore.firestore().collection("followers")
let COLLECTION_FOLLOWING = Firestore.firestore().collection("following")
let COLLECTION_POST = Firestore.firestore().collection("post")
let COLLECTION_NOTIFICATIONS = Firestore.firestore().collection("notifications")
