//
//  MessageModel.swift
//  ChatEnd
//
//  Created by Диас Мухамедрахимов on 16.05.2022.
//

import Firebase
import Foundation

struct MessageModel{
    let text: String
    let toId: String
    let fromId: String
    var timestamp: Timestamp!
    var user: UserModel?
    let isFromCurrentUser: Bool
    
    init(dictionary: [String: Any])
    {
        self.text = dictionary["text"] as? String ?? ""
        self.toId = dictionary["toId"] as? String ?? ""
        self.fromId = dictionary["fromId"] as? String ?? ""
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        
        self.isFromCurrentUser = fromId == Auth.auth().currentUser?.uid 
    }
}
