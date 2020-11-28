//
//  RegistrationController.swift
//  InstagramUIKit
//
//  Created by Javier Cueto on 23/11/20.
//

import UIKit

class RegistrationController: UIViewController {
    // MARK: -  PROPERTIES
    
    private var viewModel = RegistrationViewModel()
    private var profileImage: UIImage?
    
    private let plusPhotoButton: UIButton = {
        let button =  UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        //button.contentMode = .scaleAspectFill
        button.tintColor = .white
        button.addTarget(self, action: #selector(profilePhotoSelectHandle), for: .touchUpInside)
        return button
    }()
    
    private let emailTextField: UITextField = {
        let tf = CustomTextField(placeholder: "Email")
        tf.keyboardType = .emailAddress
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = CustomTextField(placeholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let fullNameTextField = CustomTextField(placeholder: "Fullname")
 
    
    private let UserNameTextField = CustomTextField(placeholder: "Username")
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
        button.isEnabled = false
        button.layer.cornerRadius = 5
        button.setHeight(50)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(signUpHandle), for: .touchUpInside)
        return button
    }()
    
    private let alreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: "Already have a account?  ", secondPart: "Log In")
        button.addTarget(self, action: #selector(showLoginHandle), for: .touchUpInside)
        return button
    }()
    
    // MARK: -  LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNotificationObserver()
    }
    
    
    // MARK: -  HELPERS
    
    func configureUI(){
        configureGradientLayer()
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        view.addSubview(plusPhotoButton)
        plusPhotoButton.centerX(inView: view)
        plusPhotoButton.setDimensions(height: 140, width: 140)
        plusPhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        
        
        let stack = UIStackView(arrangedSubviews: [emailTextField,passwordTextField,fullNameTextField,UserNameTextField,signUpButton, ])
        stack.axis = .vertical
        stack.spacing = 20
        view.addSubview(stack)
        stack.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.centerX(inView: view)
        alreadyHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
        
        
    }
    
    func configureNotificationObserver(){
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fullNameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        UserNameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
    }
    
    
    // MARK: -  ACCTIONS
    
    @objc func signUpHandle(){
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let fullname = fullNameTextField.text else { return }
        guard let username = UserNameTextField.text else { return }
        guard let profileImage = self.profileImage else { return }
        
        let authC = AuthCredentials(email: email, password: password, fullname: fullname, username: username, profileImage: profileImage)
        AuthService.registerUser(withCredential: authC)
    }
    
    @objc func showLoginHandle(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func textDidChange(sender: UITextField){
        if sender == emailTextField {
            viewModel.email = sender.text
        }else if sender == passwordTextField {
            viewModel.password = sender.text
        }else if sender == UserNameTextField {
            viewModel.username = sender.text
        }else {
            viewModel.fullname = sender.text
        }
        
        updateForm()
    }
    
    @objc func profilePhotoSelectHandle(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
    }
}


extension RegistrationController: FormViewModel {
    func updateForm() {
        signUpButton.backgroundColor = viewModel.buttonBackgroundColor
        signUpButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        signUpButton.isEnabled = viewModel.formIsValid
    }
    
    
}

// MARK: -  UIImagePickerControllerDelegate
extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.editedImage] as? UIImage else {return}
        
        profileImage = selectedImage
        
        plusPhotoButton.layer.cornerRadius = plusPhotoButton.frame.width / 2
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.white.cgColor
        plusPhotoButton.layer.borderWidth = 2
        plusPhotoButton.setImage(selectedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        self.dismiss(animated: true, completion: nil)
    }
}
