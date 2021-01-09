//
//  CommentViewModel.swift
//  InstagramUIKit
//
//  Created by Javier Cueto on 09/01/21.
//

import UIKit

struct CommentViewModel {
    private let comment: Comment
    
    var profileImage: URL? {
        return URL(string: comment.profileImageUrl)
    }
    
  
    
    var commentText: NSAttributedString {
        
        let attributedString = NSMutableAttributedString(string: "\(comment.username)  ", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedString.append(NSMutableAttributedString(string: comment.commentText, attributes: [.font: UIFont.systemFont(ofSize: 14)]))
        
        return attributedString
        
    }
    
    func size(forWith with: CGFloat) -> CGSize{
        let label = UILabel()
        label.numberOfLines = 0
        label.text = comment.commentText
        label.lineBreakMode = .byWordWrapping
        label.setWidth(with)
        
        return label.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }
    
    init(comment: Comment){
        self.comment = comment
    }
}
