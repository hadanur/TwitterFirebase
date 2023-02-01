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
    func logInAuthError(errorMessage: String)
    func logInEmptyError()
}

class HomeVM {
    weak var delegate: HomeVMDelegate?
    
    func createUserButtonTapped(email: String, password: String){
        if email != "", password != "" {
            Auth.auth().createUser(withEmail: email, password: password) { (authdata, error) in
                if let _ = error {
                    self.delegate?.createUserError()
                } else {
                    self.delegate?.createUserSuccess()
                }
            }
        } else {
            self.delegate?.createUserError()
        }
    }
    
    func loginButtonTapped(email: String, password: String){
        if email != "", password != "" {
            Auth.auth().signIn(withEmail: email, password: password) { (authdata, error) in
                if let error = error {
                    self.delegate?.logInAuthError(errorMessage: error.localizedDescription)
                } else {
                    self.delegate?.logInSuccess()
                }
            }
        } else {
            self.delegate?.logInEmptyError()
        }
    }
    
}
