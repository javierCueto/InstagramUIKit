//
//  UploadPostController.swift
//  InstagramUIKit
//
//  Created by Javier Cueto on 20/12/20.
//

import UIKit

protocol UploadPostControllerDelegate: class {
    func controllerDidFinishUploadingPost(_ controller: UploadPostController)
}

class UploadPostController: UIViewController{
    
  
    // MARK: -  PROPERTIES
    weak var delegate: UploadPostControllerDelegate?
    var selectedImage: UIImage? {
        didSet{
            photoImageVIew.image = selectedImage
        }
    }
    
    private let photoImageVIew: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private lazy var captionTextView: InputTextView = {
        let tv = InputTextView()
        tv.placeHolderText = "Enter caption..."
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.delegate = self
        return tv 
    }()
    
    private let characterCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "0/100"
        return label
    }()
    // MARK: -  LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: -  ACTIONS
    @objc func didTapCancel(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func didTapDone(){
        guard let image = selectedImage else {return}
        guard let caption = captionTextView.text else {return}
        showLoader(true)
        PostService.uploadPost(caption: caption, image: image) { (error) in
            self.showLoader(false)
            if let error = error {
                myPrint("Failed to upload post with error \(error)")
                return
            }
           
            self.delegate?.controllerDidFinishUploadingPost(self)
        }
    }
    
    // MARK: -  HELPERS
    func checkMaxLenght(_ textView: UITextView){
        if (textView.text.count) > 100 {
            textView.deleteBackward()
        }
    }
    func configureUI(){
        navigationItem.title = "Upload Post"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancel))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share",style: .done ,target: self, action: #selector(didTapDone))
        view.backgroundColor = .white
        
        
        view.addSubview(photoImageVIew)
        photoImageVIew.setDimensions(height: 180, width: 180)
        photoImageVIew.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 8)
        photoImageVIew.centerX(inView: view )
        photoImageVIew.layer.cornerRadius = 10
        
        view.addSubview(captionTextView)
        captionTextView.anchor(top: photoImageVIew.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: 12, paddingRight: 12, height: 64)
        
        view.addSubview(characterCountLabel)
        characterCountLabel.anchor(bottom: captionTextView.bottomAnchor, right:  view.rightAnchor, paddingBottom: -8 ,paddingRight: 12)
    }
}

extension UploadPostController: UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        checkMaxLenght(textView)
        let count = textView.text.count
        characterCountLabel.text = "\(count)/100"
    }
}

