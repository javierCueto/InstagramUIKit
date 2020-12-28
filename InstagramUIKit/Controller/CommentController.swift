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
        cell.backgroundColor = .red
        return cell
    }
}

// MARK: - UICollectionVIewDelegateFlowLayout
extension CommentController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 80)
    }
}
