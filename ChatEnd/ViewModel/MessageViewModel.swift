//
//  MessageViewModel.swift
//  ChatEnd
//
//  Created by Диас Мухамедрахимов on 16.05.2022.
//

import Foundation
import UIKit

struct MesssageViewModel{
    private let message: MessageModel
    
    var messageBackColor: UIColor {
        return message.isFromCurrentUser ? .lightGray : .systemRed
    }
    var messageTextColor: UIColor {
        return message.isFromCurrentUser ? .black : .white
    }
    var rightAnchorActive: Bool{
        return message.isFromCurrentUser
    }
    var leftAnchorActive: Bool{
        return !message.isFromCurrentUser
    }
    var hideProfile: Bool{
        return message.isFromCurrentUser
    }
    var profileImageUrl: URL?{
        guard let user = message.user else {return nil}
        return URL(string: user.profileImageUrl)
    }
    
    init(message: MessageModel){
        self.message = message
    }
    
}
