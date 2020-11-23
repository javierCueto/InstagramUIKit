//
//  FeedCell.swift
//  InstagramUIKit
//
//  Created by Javier Cueto on 23/11/20.
//

import UIKit

class FeedCell: UICollectionViewCell {
    
    // MARK: -  PROPERTIES
    private let profileImageView: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.image = #imageLiteral(resourceName: "venom-7")
        return iv
    }()
    
    private lazy var userNameButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Venom", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.addTarget(self, action: #selector(didTapUserName), for: .touchUpInside)
        
        return button
    }()
    // MARK: -  LIFECYCLE
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor,paddingTop: 12, paddingLeft: 12)
        
        profileImageView.setDimensions(height: 40, width: 40)
        print(profileImageView.bounds.height )
        profileImageView.layer.cornerRadius = 40 / 2
        
        addSubview(userNameButton)
        userNameButton.centerY(inView: profileImageView, leftAnchor: profileImageView.rightAnchor, paddingLeft: 8)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: -  ACTIONS
    
    @objc func didTapUserName(){
        myPrint("Did tap username")
    }
    
}
