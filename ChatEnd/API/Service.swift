//
//  Service.swift
//  ChatEnd
//
//  Created by Диас Мухамедрахимов on 16.05.2022.
//

import Foundation
import FirebaseFirestore
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
}
