//
//  HomeVC.swift
//  TwitterFirebase
//
//  Created by Hakan Adanur on 26.01.2023.
//

import UIKit
import Firebase
import FirebaseAuth

class HomeVC: UIViewController {
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var viewModel: HomeVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self

    }
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        if usernameField.text != "",
           passwordField.text != "" {
            viewModel.userSignIn(email: usernameField.text!, password: passwordField.text!)
        } else {
            viewModel.delegate?.logInError()
        }
    }
    
    @IBAction func createUserButtonClicked(_ sender: Any) {
        if usernameField.text != "",
           passwordField.text != "" {
            viewModel.userSignUp(email: usernameField.text!, password: passwordField.text!)
        } else {
            viewModel.delegate?.createUserError()
        }
    }
}

extension HomeVC {
    static func create() -> HomeVC {
        let vc = HomeVC(nibName: "HomeVC", bundle: nil)
        vc.viewModel = HomeVM()
        return vc
    }
}

extension HomeVC: HomeVMDelegate {
    func logInSuccess() {
        navigationController?.pushViewController(FeedVC.create(), animated: true)
    }
    
    func logInError() {
        self.showAlert(title: "Hata", message: "Kullanıcı adı veya Parola yanlış")
    }
    
    func createUserSuccess() {
        navigationController?.pushViewController(FeedVC.create(), animated: true)
    }
    
    func createUserError() {
        self.showAlert(title: "Hata", message: "Hesap Oluşturalamadı")
    }
    
    
}
