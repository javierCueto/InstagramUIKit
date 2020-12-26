//
//  ProfileCell.swift
//  InstagramUIKit
//
//  Created by Javier Cueto on 30/11/20.
//

import UIKit

class ProfileCell: UICollectionViewCell {
    
    // MARK: -  PROPERTIES
    var viewModel: PostViewModel? {
        didSet{
            configure()
        }
    }
    private let postImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "venom-7")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    // MARK: -  LIFECYCLE
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        
        addSubview(postImageView)
        postImageView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -  HELPERS
    
    func configure(){
        guard let viewModel = viewModel else {return}
        postImageView.sd_setImage(with: viewModel.imageUrl)
    }
}
