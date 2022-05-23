//
//  ClubViewModel.swift
//  ChatEnd
//
//  Created by Диас Мухамедрахимов on 23.05.2022.
//

import Foundation
enum ClubViewModel: Int, CaseIterable {
    case cpu
    case gpu
    case monitor
    case mouse
    case ram
    case keyboard
    var description: String{
        switch self {
        case .cpu: return "CPU"
        case .gpu: return "GPU"
        case .monitor: return "Monitor"
        case .mouse: return "Mouse"
        case .ram: return "Ram"
        case .keyboard: return "Keyboard"
        }
    }
    var iconImageName: String{
        switch self {
        case .cpu: return "cpuLogo"
        case .gpu: return "gpuLogo"
        case .monitor: return "monitorLogo"
        case .mouse: return "mouseLogo"
        case .ram: return "ramLogo"
        case .keyboard: return "keyboardLogo"
        
        }
    }
}
