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
    @IBOutlet private weak var usernameField: UITextField!
    @IBOutlet private weak var passwordField: UITextField!
    
    private var viewModel: HomeVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
    }
    
    @IBAction private func loginButtonClicked(_ sender: Any) {
        guard let username = usernameField.text, let password = passwordField.text else { return }
        viewModel.loginButtonTapped(email: username, password: password)
    }
    
    @IBAction private func createUserButtonClicked(_ sender: Any) {
        guard let username = usernameField.text, let password = passwordField.text else { return }
        viewModel.createUserButtonTapped(email: username, password: password)
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
    func logInAuthError(errorMessage: String) {
        self.showAlert(title: "Hata", message: errorMessage)
    }
    
    func logInEmptyError() {
        self.showAlert(title: "Hata", message: "Boş")
    }
    
    func logInSuccess() {
        navigationController?.pushViewController(FeedVC.create(), animated: true)
    }
    
    func createUserSuccess() {
        navigationController?.pushViewController(FeedVC.create(), animated: true)
    }
    
    func createUserError() {
        self.showAlert(title: "Hata", message: "Hesap Oluşturalamadı")
    }
    
    
}
