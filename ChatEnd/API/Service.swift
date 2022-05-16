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
    COLLECTION_USERS.getDocuments { snapshot, error in
            snapshot?.documents.forEach({ document in
                let dictionary = document.data()
                let user = UserModel(dictionary: dictionary)
                users.append(user)
                completion(users)
            })
        }
    }
    static func fetchUser(withUid uid: String, completion: @escaping(UserModel) -> Void)  {
        COLLECTION_USERS.document(uid).getDocument  { (snapshot, error) in
            guard let dictionary =  snapshot?.data() else {return}
            let user = UserModel(dictionary: dictionary)
            completion(user)
        }
    }
    static func fetchConversations (completion: @escaping([Conversation]) -> Void){
        var conversations  = [Conversation]()
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        let query = COLLECTION_MESSAGES.document(uid).collection("recent-messages ").order(by: "timestamp")
        
        query.addSnapshotListener { (snapshot, error) in
            snapshot?.documentChanges.forEach({ change in
                let dictionary = change.document.data()
                let message = MessageModel(dictionary: dictionary)
                
                self.fetchUser(withUid: message.toId) { user in
                    let conversation = Conversation(user: user, message: message)
                    conversations.append(conversation)
                    completion(conversations)
                }
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
           
           
           COLLECTION_MESSAGES.document(currentId).collection("recent-messages").document(user.uid).setData(data)
           COLLECTION_MESSAGES.document(user.uid).collection("recent-messages").document(currentId).setData(data)
        }
    }
}
