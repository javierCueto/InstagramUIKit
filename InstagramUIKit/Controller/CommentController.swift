//
//  CommentController.swift
//  InstagramUIKit
//
//  Created by Javier Cueto on 28/12/20.
//

import UIKit

private let reuseIdentifier = "CommentCell"
class CommentController: UICollectionViewController {
    // MARK: -  Properties
    private let post: Post
    private var comments = [Comment]()
    private lazy var commentInputView: CommentInputAccesoryView = {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        let cv = CommentInputAccesoryView(frame: frame)
        cv.delegate = self
        return cv
    }()
    // MARK: -  LifeCycle
    init(post: Post){
        self.post = post
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        fetchComment()
    }
    // MARK: -  Helpers
    func configureCollectionView(){
        collectionView.backgroundColor = .white
        navigationItem.title = "Comments"
        collectionView.register(CommentCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.alwaysBounceVertical = true
        collectionView.keyboardDismissMode = .interactive
    }
    
    override var inputAccessoryView: UIView?{
        get { return commentInputView}
    }
    
    override var canBecomeFirstResponder: Bool{
        true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    // MARK: -  Actions
    // MARK: -  API
    
    func fetchComment(){
        CommentService.fetchComments(forPost: post.postID) { (comments) in
            self.comments = comments
            self.collectionView.reloadData()
        }
    }
    
}


// MARK: -  UICollectionViewDataSource
extension CommentController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        comments.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CommentCell
        cell.viewModel = CommentViewModel(comment: comments[indexPath.row])
        return cell
    }
}


// MARK: -  UICollectionViewDelegate
extension CommentController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let uid = comments[indexPath.row].uid
        UserService.fetchUser(withUid: uid) { (user) in
            let controller = ProfileController(user: user)
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}

// MARK: - UICollectionVIewDelegateFlowLayout
extension CommentController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewModel = CommentViewModel(comment: comments[indexPath.row])
        let height = viewModel.size(forWith: view.frame.width).height + 32
        
        return CGSize(width: view.frame.width, height: height)
    }
}

extension CommentController: CommentInputAccesoryViewDelegate {
    func inputView(_ inputView: CommentInputAccesoryView, wantsToUploadComment comment: String) {
        
        
        guard let tab = self.tabBarController as? MainTabController else { return }
        guard let currentUser = tab.user else {return}
        
        showLoader(true)
        CommentService.uploadComment(comment: comment, postID: post.postID, user: currentUser) { (error) in
            self.showLoader(false)
            inputView.clearCommentTextView()
            
            NotificationService.uploadNotification(toUid: self.post.ownerUid, fromUser: currentUser, type: .comment, post: self.post)
        }
        
    }
    
    
}
