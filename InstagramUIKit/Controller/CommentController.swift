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
    private lazy var commentInputView: CommentInputAccesoryView = {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        let cv = CommentInputAccesoryView(frame: frame)
        cv.delegate = self
        return cv
    }()
    // MARK: -  LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
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
    
}


// MARK: -  UICollectionViewDataSource
extension CommentController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        9
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        return cell
    }
}

// MARK: - UICollectionVIewDelegateFlowLayout
extension CommentController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 80)
    }
}

extension CommentController: CommentInputAccesoryViewDelegate {
    func inputView(_ inputView: CommentInputAccesoryView, wantsToUploadComment comment: String) {
        print(comment)
        inputView.clearCommentTextView()
    }
    
    
}
