//
//  ProfileHeaderViewModel.swift
//  InstagramUIKit
//
//  Created by Javier Cueto on 05/12/20.
//

import UIKit

struct ProfileHeaderViewModel{
    let user: User
    
    var fullname: String {
        return user.fullname
    }
    
    
    var profileImageUrl: URL? {
        return URL(string: user.profileImageUrl)
    }
    
    
    init(user: User){
        self.user = user
    }
    
}
