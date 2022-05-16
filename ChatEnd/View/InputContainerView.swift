//
//  InputContainerView.swift
//  ChatEnd
//
//  Created by Диас Мухамедрахимов on 15.05.2022.
//

import UIKit

class InputContainerView: UIView{
    
    init(imageOf: UIImage, textField: UITextField){
        super.init(frame: .zero)
        setHeight(height: 50)
        let image = UIImageView()
        image.image = imageOf
        image.tintColor = .red
        addSubview(image)
        image.centerY(inView: self)
        image.anchor(left: leftAnchor, paddingLeft: 8)
        image.setDimensions(height: 24, width: 24)
        addSubview(textField)
        textField.centerY(inView: self)
        textField.anchor(left: image.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingLeft: 8, paddingBottom: -8)
        
        let dividerView = UIView()
        dividerView.backgroundColor = .black
        addSubview(dividerView)
        dividerView.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingLeft: 8, height: 0.75)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
