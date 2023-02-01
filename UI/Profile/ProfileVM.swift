//
//  ProfileVM.swift
//  TwitterFirebase
//
//  Created by Hakan Adanur on 27.01.2023.
//

import Foundation
import UIKit
import Firebase

protocol ProfileVMDelegate: AnyObject {
    func getDataSuccess()
    func getDataError()
    func getUserMailError()
    func getUserMail(_ mail: String)
    func logout()
    func logoutError()
}

class ProfileVM {
    weak var delegate: ProfileVMDelegate?
    var tweets = [TweetModel]()

    func fetchUserName() {
        do {
            let userMail = try Auth.auth().currentUser?.email

            if let userMail = userMail {
                delegate?.getUserMail(userMail)
            }
        } catch {
            delegate?.getUserMailError()
        }
    }

    func logoutButtonTapped() {
        do {
            try Auth.auth().signOut()
            delegate?.logout()
        } catch {
            delegate?.logoutError()
        }
    }
    
    func viewDidLoad(){
        let fireStoreDatabase = Firestore.firestore()
        
        fireStoreDatabase.collection("Tweets").addSnapshotListener { (snapshot, error) in
            if error != nil {
                self.delegate?.getDataError()
            } else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    for document in snapshot!.documents {
                        let documentID = document.documentID
                        print(documentID)
                        
                        if let tweetedBy = document.get("tweetedBy") as? String,
                           let tweetDescription = document.get("tweetDescription") as? String{
                            self.tweets.append(TweetModel(tweetedBy: tweetedBy, tweetDescription: tweetDescription))
                            DispatchQueue.main.async {
                                self.delegate?.getDataSuccess()
                            }
                        }
                    }
                }
            }
        }
    }
}
