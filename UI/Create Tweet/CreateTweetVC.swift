//
//  CreateTweetVC.swift
//  TwitterFirebase
//
//  Created by Hakan Adanur on 27.01.2023.
//

import UIKit

class CreateTweetVC: UIViewController {

    @IBOutlet weak var userTextView: UITextView!
    
    var viewModel: CreateTweetVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self

        userTextView.layer.borderWidth = 0.55
        userTextView.layer.cornerRadius = 4
        userTextView.layer.borderColor = CGColor(red: 0.0 / 255.0, green: 0.0 / 255.0, blue: 0.0 / 255.0, alpha: 0.15)
    }
    @IBAction func createButtonClicked(_ sender: Any) {
        viewModel.createTweet(tweetDescription: userTextView.text)
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}

extension CreateTweetVC {
    static func create() -> CreateTweetVC {
        let vc = CreateTweetVC(nibName: "CreateTweetVC", bundle: nil)
        vc.viewModel = CreateTweetVM()
        return vc
    }
}

extension CreateTweetVC: CreateTweetVMDelegate {
    func createTweetSuccess() {
        navigationController?.popViewController(animated: true)
    }
    
    func createTweetError() {
        self.showAlert(title: "Hata", message: "Tweet Oluşturulamadı")
    }
    
    
}
