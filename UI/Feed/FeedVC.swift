//
//  FeedVC.swift
//  TwitterFirebase
//
//  Created by Hakan Adanur on 26.01.2023.
//

import UIKit
import Firebase
import FirebaseDatabase

class FeedVC: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    private var viewModel: FeedVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let feedCell = UINib(nibName: "FeedCell", bundle: nil)
        tableView.register(feedCell, forCellReuseIdentifier: "feedCell")

        tableView.delegate = self
        tableView.dataSource = self
        viewModel.delegate = self

        viewModel.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(profileButtonClicked))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createButtonClicked))
    }

    @objc private func profileButtonClicked(){
        navigationController?.pushViewController(ProfileVC.create(), animated: true)
    }
    
    @objc private func createButtonClicked(){
        navigationController?.pushViewController(CreateTweetVC.create(), animated: true)
    }
}

extension FeedVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell") as! FeedCell
        cell.selectionStyle = .none
        let data = viewModel.tweets[indexPath.row]
        cell.configure(tweet: data)
        return cell
    }
}

extension FeedVC {
    static func create() -> FeedVC {
        let vc = FeedVC(nibName: "FeedVC", bundle: nil)
        vc.viewModel = FeedVM()
        return vc
    }
}

extension FeedVC: FeedVMDelegate {
    func getDataSuccess() {
        tableView.reloadData()
    }
    
    func getDataError() {
        showAlert(title: "Hata", message: "Veriler Yüklenemedi.")
    }
    
    
}
