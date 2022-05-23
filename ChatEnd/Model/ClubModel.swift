//
//  ClubModel.swift
//  ChatEnd
//
//  Created by Диас Мухамедрахимов on 22.05.2022.
//

import Foundation

struct ClubModel{
    let id: String
    let imageLogoUrl: String
    let imageMainUrl: String
    let name: String
    let address: String
    let monitor: String
    let mouse: String
    let cpu: String
    let gpu: String
    let ram: String
    let keyboard: String
    
    init(dictionary: [String: Any]){
        self.id = dictionary["id"] as? String ?? ""
        self.imageLogoUrl = dictionary["imageLogoUrl"] as? String ?? ""
        self.imageMainUrl = dictionary["imageMainUrl"] as? String ?? ""
        self.name = dictionary["name"] as? String ?? ""
        self.address = dictionary["address"] as? String ?? ""
        self.monitor = dictionary["monitor"] as? String ?? ""
        self.mouse = dictionary["mouse"] as? String ?? ""
        self.cpu = dictionary["cpu"] as? String ?? ""
        self.gpu = dictionary["gpu"] as? String ?? ""
        self.ram = dictionary["ram"] as? String ?? ""
        self.keyboard = dictionary["keyboard"] as? String ?? ""
    }
}
