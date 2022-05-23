//
//  ProfileVIewModel.swift
//  ChatEnd
//
//  Created by Диас Мухамедрахимов on 23.05.2022.
//

import Foundation

enum ProfileViewModel: Int, CaseIterable {
    case favorites
    case settings
    
    var description: String{
        switch self {
        case .favorites: return "Favorite Clubs"
        case .settings: return "Settings"
        
        }
    }
    var iconImageName: String{
        switch self {
        case .favorites: return "heartLogo"
        case .settings: return "gear"
        
        }
    }
}
