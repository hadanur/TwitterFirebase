//
//  FeedVM.swift
//  TwitterFirebase
//
//  Created by Hakan Adanur on 27.01.2023.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase

protocol FeedVMDelegate: AnyObject {
    func getDataSuccess()
    func getDataError()
}
class FeedVM {
    var tweets = [TweetModel]()
    weak var delegate: FeedVMDelegate?
    
    func getDataFromFirebase(){
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
