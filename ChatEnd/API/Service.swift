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
    static func fetchClubs(completion: @escaping([ClubModel]) -> Void){
        var clubs = [ClubModel]()
        Firestore.firestore().collection("clubs").getDocuments { snapshot, error in
            snapshot?.documents.forEach({ document in
                let dictionary = document.data()
                let club = ClubModel(dictionary: dictionary)
                clubs.append(club)
                completion(clubs)
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
    static func fetchClub(withId id: String, completion: @escaping(ClubModel) -> Void)  {
        Firestore.firestore().collection("clubs").document(id).getDocument  { (snapshot, error) in
            guard let dictionary =  snapshot?.data() else {return}
            let club = ClubModel(dictionary: dictionary)
            completion(club)
        }
    }

}
