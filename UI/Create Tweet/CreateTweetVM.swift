//
//  CreateTweetVM.swift
//  TwitterFirebase
//
//  Created by Hakan Adanur on 27.01.2023.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase

protocol CreateTweetVMDelegate: AnyObject {
    func createTweetSuccess()
    func createTweetError()
}
class CreateTweetVM {
    weak var delegate: CreateTweetVMDelegate?
    
    func createTweet(tweetDescription: String){
        
        let firestoreDatabase = Firestore.firestore()
        
        var firestoreReferance: DocumentReference? = nil
        
        let firestoreTweet = ["tweetedBy": Auth.auth().currentUser!.email!, "tweetDescription": tweetDescription] as [String: Any]
        
        firestoreReferance = firestoreDatabase.collection("Tweets").addDocument(data: firestoreTweet, completion: { (error) in
            if error != nil {
                self.delegate?.createTweetError()
            } else {
                self.delegate?.createTweetSuccess()
            }
        })
    }
}
