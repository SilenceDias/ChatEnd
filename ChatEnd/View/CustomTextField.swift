//
//  CustomTextField.swift
//  ChatEnd
//
//  Created by Диас Мухамедрахимов on 15.05.2022.
//

import UIKit

class CustomTextField: UITextField {
    init(placeholder: String)
    {
        super.init(frame: .zero)
        
        borderStyle = .none
        font = UIFont.boldSystemFont(ofSize: 16)
        textColor = .black
        keyboardAppearance = .dark
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
