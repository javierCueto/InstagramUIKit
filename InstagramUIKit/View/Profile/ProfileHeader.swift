//
//  ProfileHeader.swift
//  InstagramUIKit
//
//  Created by Javier Cueto on 30/11/20.
//

import UIKit

class ProfileHeader: UICollectionReusableView {
    // MARK: -  PROPERTIES
    
    // MARK: -  LIFECYCLE
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -  HELPERS
}


