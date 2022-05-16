//
//  LoginViewModel.swift
//  ChatEnd
//
//  Created by Диас Мухамедрахимов on 16.05.2022.
//

import Foundation

protocol AuthProtocol {
    var formIsValid : Bool { get }
}

struct LoginViewModel: AuthProtocol{
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }
}
