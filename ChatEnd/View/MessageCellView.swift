//
//  MessageCellView.swift
//  ChatEnd
//
//  Created by Диас Мухамедрахимов on 16.05.2022.
//

import Foundation
import UIKit

class MessageCellView: UICollectionViewCell{
    
    var message: MessageModel?{
        didSet {configure()}
    }
    var containerLeftAnchor: NSLayoutConstraint!
    var containerRightAnchor: NSLayoutConstraint!
    private let profImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    private let textView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.textColor = .white
        return textView
    }()
    private let messageContainer: UIView = {
        let container = UIView()
        container.backgroundColor = .systemPurple
        return container
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(profImageView)
        profImageView.anchor(left: leftAnchor, bottom: bottomAnchor, paddingLeft: 8, paddingBottom: -4)
        profImageView.setDimensions(height: 32, width: 32)
        profImageView.layer.cornerRadius = 32 / 2
        addSubview(messageContainer)
        messageContainer.layer.cornerRadius = 12
        messageContainer.anchor(top: topAnchor)
        messageContainer.widthAnchor.constraint(lessThanOrEqualToConstant: 250).isActive = true
        containerLeftAnchor = messageContainer.leftAnchor.constraint(equalTo: profImageView.rightAnchor, constant: 12)
        containerLeftAnchor.isActive = false
        containerRightAnchor = messageContainer.rightAnchor.constraint(equalTo: rightAnchor, constant: -12)
        containerRightAnchor.isActive = false
        messageContainer.addSubview(textView)
        textView.anchor(top: messageContainer.topAnchor, left: messageContainer.leftAnchor, bottom: messageContainer.bottomAnchor, right: messageContainer.rightAnchor, paddingTop: 4, paddingLeft: 12, paddingBottom: 4, paddingRight: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(){
        guard let message = message else {return}
        let viewModel = MesssageViewModel(message: message )
        
        messageContainer.backgroundColor = viewModel.messageBackColor
        textView.textColor = viewModel.messageTextColor
        textView.text = message.text
        
        containerLeftAnchor.isActive = viewModel.leftAnchorActive
        containerRightAnchor.isActive = viewModel.rightAnchorActive
        profImageView.isHidden = viewModel.hideProfile
        profImageView.sd_setImage(with: viewModel.profileImageUrl)
    }
}
