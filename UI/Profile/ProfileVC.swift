//
//  ProfileVC.swift
//  TwitterFirebase
//
//  Created by Hakan Adanur on 26.01.2023.
//

import UIKit
import Firebase

class ProfileVC: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var userEmail: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!
    
    var viewModel: ProfileVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userFeedCell = UINib(nibName: "UserFeedCell", bundle: nil)
        tableView.register(userFeedCell, forCellReuseIdentifier: "userFeedCell")

        tableView.delegate = self
        tableView.dataSource = self
        viewModel.delegate = self

        viewModel.viewDidLoad()
        setupUI()
    }
    
    @objc private func logoutButtonClicked() {
        viewModel.logoutButtonTapped()
    }
    
    private func setupUI() {
        title = "Profil"

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(logoutButtonClicked))

        profilePicture.layer.cornerRadius = 24
        profilePicture.layer.borderWidth = 2
        profilePicture.layer.borderColor = UIColor.white.cgColor
    }
}

extension ProfileVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userFeedCell") as! UserFeedCell
        let data = viewModel.tweets[indexPath.row]
        cell.configure(tweet: data)
        cell.selectionStyle = .none
        return cell
    }
}

extension ProfileVC {
    static func create() -> ProfileVC {
        let vc = ProfileVC(nibName: "ProfileVC", bundle: nil)
        vc.viewModel = ProfileVM()
        return vc
    }
}

extension ProfileVC: ProfileVMDelegate {
    func getDataSuccess() {
        self.tableView.reloadData()
    }
    
    func getDataError() {
        self.showAlert(title: "Hata", message: "Tekrar Deneyin.")
    }
    
    func getUserMail(_ mail: String) {
        userEmail.text = mail
    }

    func getUserMailError() {
        self.showAlert(title: "Hata", message: "Tekrar Deneyin.")
    }

    func logout() {
        navigationController?.pushViewController(HomeVC.create(), animated: true)
    }

    func logoutError() {
        self.showAlert(title: "Error", message: "Çıkış Yapılamadı")
    }
}

