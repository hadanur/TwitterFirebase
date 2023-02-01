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
    
    func viewDidLoad(){
        let collection = Firestore.firestore().collection("Tweets")
        
        collection.addSnapshotListener { (snapshot, error) in
            guard let snapshot = snapshot else {
                self.delegate?.getDataError()
                return
            }
            
            if !snapshot.isEmpty {
                for document in snapshot.documents {
                    let _ = document.documentID
                    
                    let tweet = TweetModel(tweetedBy: document.get("tweetedBy") as? String,
                                           tweetDescription: document.get("tweetDescription") as? String)
                    
                    self.tweets.append(tweet)
                    
                    DispatchQueue.main.async {
                        self.delegate?.getDataSuccess()
                    }
                }
            }
        }
    }
}
