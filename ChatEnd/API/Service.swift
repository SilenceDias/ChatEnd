//
//  Service.swift
//  ChatEnd
//
//  Created by Диас Мухамедрахимов on 16.05.2022.
//

import Foundation
import FirebaseFirestore
import Firebase
struct Service{
    static func fetchUsers(completion: @escaping([UserModel]) -> Void){
        var users = [UserModel]()
        Firestore.firestore().collection("users").getDocuments { snapshot, error in
            snapshot?.documents.forEach({ document in
                let dictionary = document.data()
                let user = UserModel(dictionary: dictionary)
                users.append(user)
                completion(users)
            })
        }
    }
    
    static func fetchMessages(forUser user: UserModel, completion: @escaping([MessageModel]) -> Void){
        var messages = [MessageModel]()
        
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
        let query = COLLECTION_MESSAGES.document(currentUid).collection(user.uid).order(by: "timestamp")
        
        query.addSnapshotListener { (snapshot, error) in
            snapshot?.documentChanges.forEach({ change in
                if change.type == .added {
                    let dictionary = change.document.data()
                    messages.append(MessageModel(dictionary: dictionary))
                    completion(messages)
                }
            })
        }
    }
    
    static func uploadMessages(_ message: String, to user: UserModel, comletion:((Error?) -> Void)?){
        guard let currentId = Auth.auth().currentUser?.uid else {return}
        
        
        let data = ["text": message, "fromId": currentId, "toId": user.uid,  "timestamp": Timestamp(date: Date())] as [String : Any]
       COLLECTION_MESSAGES.document(currentId).collection(user.uid).addDocument(data: data) { _ in
           COLLECTION_MESSAGES.document(user.uid).collection(currentId).addDocument(data: data, completion: comletion)
        }
    }
}
