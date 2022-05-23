//
//  ProfileHeaderView.swift
//  ChatEnd
//
//  Created by Диас Мухамедрахимов on 23.05.2022.
//

import UIKit
import Firebase

protocol ProfileHeaderDelegate: AnyObject{
    func dismissController()
}


class ProfileHeaderView: UIView {
    var user: UserModel?{
        didSet{ populateUserdata() }
    }
    weak var delegate: ProfileHeaderDelegate?
    
    private let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "xMark"), for: .normal)
        button.imageView?.tintColor = .white
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        button.tintColor = .white
        button.imageView?.setDimensions(height: 22, width: 22)
        return button
    }()
    
    private let profileImageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.layer.borderColor = UIColor.white.cgColor
        image.layer.borderWidth = 4.0
        return image
    }()
    private let fullnameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    @objc func handleDismiss(){
        delegate?.dismissController()
    }
    func populateUserdata(){
        guard let user = user else {return }
        fullnameLabel.text = user.fullName
        usernameLabel.text = "@" + user.username
        guard let url = URL(string: user.profileImageUrl) else {return}
        profileImageView.sd_setImage(with: url)
    }
    func configureUi(){
        backgroundColor = .red
        profileImageView.setDimensions(height: 200, width: 200)
        profileImageView.layer.cornerRadius = 200 / 2
        addSubview(profileImageView)
        profileImageView.centerX(inView: self)
        profileImageView.anchor(top: topAnchor, paddingTop: 96)
        let stack = UIStackView(arrangedSubviews: [fullnameLabel,usernameLabel])
        stack.axis = .vertical
        stack.spacing = 4
        addSubview(stack)
        stack.centerX(inView: self)
        stack.anchor(top: profileImageView.bottomAnchor, paddingTop: 16)
        addSubview(dismissButton)
        dismissButton.anchor(top: topAnchor, left: leftAnchor, paddingTop: 44, paddingLeft: 12)
        dismissButton.setDimensions(height: 44, width: 44)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUi()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


