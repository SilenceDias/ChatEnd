//
//  CustiomInputView.swift
//  ChatEnd
//
//  Created by Диас Мухамедрахимов on 16.05.2022.
//

import UIKit

protocol CustomInputViewDelegate: class{
    func inputView(_ inputView: CustomInputView, wantsToSend message: String)
}

class CustomInputView : UIView{
    
    
    weak var delegate: CustomInputViewDelegate?

    public lazy var messageText: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.isScrollEnabled = false
        return textView
    }()
    private lazy var sendButtin: UIButton = {
        let button = UIButton()
        button.setTitle("Send", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.systemRed, for: .normal)
        button.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        return button
    }()
    
    private lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter Message"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .lightGray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame )
         backgroundColor = .white
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 10
        layer.shadowOffset = .init(width: 0, height: -8)
        layer.shadowColor = UIColor.lightGray.cgColor
        autoresizingMask = .flexibleHeight
        addSubview(sendButtin)
        sendButtin.anchor( top: topAnchor, right: rightAnchor, paddingTop: 4, paddingRight: 8)
        sendButtin.setDimensions(height: 50, width: 50)
        addSubview(messageText)
        messageText.anchor(top: topAnchor, left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: sendButtin.leftAnchor, paddingTop: 12, paddingLeft: 4, paddingBottom: 8, paddingRight: 8 )
        addSubview(placeholderLabel)
        placeholderLabel.anchor(left: messageText.leftAnchor, paddingLeft: 4)
        placeholderLabel.centerY(inView: messageText)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleInputChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func handleInputChange(){
        placeholderLabel.isHidden = !self.messageText.text.isEmpty
    }
    @objc func handleSend(){
        guard let text = messageText.text else {return}
        delegate?.inputView(self, wantsToSend: text )
    }
    override var intrinsicContentSize: CGSize {
        return .zero 
    }
}
