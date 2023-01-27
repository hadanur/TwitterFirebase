//
//  HomeVM.swift
//  TwitterFirebase
//
//  Created by Hakan Adanur on 26.01.2023.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth

protocol HomeVMDelegate: AnyObject {
    func createUserSuccess()
    func createUserError()
    func logInSuccess()
    func logInError()
}

class HomeVM {
    weak var delegate: HomeVMDelegate?
    
    func userSignUp(email: String, password: String){
        Auth.auth().createUser(withEmail: email, password: password) { (authdata, error) in
            if error != nil {
                self.delegate?.createUserError()
            } else {
                self.delegate?.createUserSuccess()
            }
        }
    }
    
    func userSignIn(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) { (authdata, error) in
            if error != nil {
                self.delegate?.logInError()
            } else {
                self.delegate?.logInSuccess()
            }
        }
    }
    
}
