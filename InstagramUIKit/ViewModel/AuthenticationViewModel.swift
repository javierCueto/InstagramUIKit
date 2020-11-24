//
//  AuthenticationViewModel.swift
//  InstagramUIKit
//
//  Created by Javier Cueto on 24/11/20.
//

import UIKit

struct LoginViewModel {
    var email: String?
    var password: String?
    var formIsValid : Bool {
        return email?.isEmpty == false && password?.isEmpty == false 
    }
    
    var buttonBackGroundColor: UIColor {
        return formIsValid ? #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1) : #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
    }
    
    var buttonTitleColor: UIColor {
        return formIsValid ?  .white : UIColor(white: 1, alpha: 0.67)
    }
}

struct RegistrationViewModel {
    
}
