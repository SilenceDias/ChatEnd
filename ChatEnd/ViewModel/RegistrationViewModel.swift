//
//  RegistrationViewModel.swift
//  ChatEnd
//
//  Created by Диас Мухамедрахимов on 16.05.2022.
//

import Foundation

struct RegistrationViewModel: AuthProtocol{
    var email: String?
    var password: String?
    var fullname: String?
    var username: String?
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false && fullname?.isEmpty == false && username?.isEmpty == false
    }
}
