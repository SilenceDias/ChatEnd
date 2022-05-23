//
//  ProfileFooterVIew.swift
//  ChatEnd
//
//  Created by Диас Мухамедрахимов on 23.05.2022.
//

import UIKit

protocol ProfileFooterDelegate: AnyObject{
    func handleLogout()
}

class ProfileFooterVIew: UIView {
    
    weak var delegate: ProfileFooterDelegate?
    private lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Logout", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = .red
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(logoutButton)
        logoutButton.anchor(left: leftAnchor, right: rightAnchor, paddingLeft: 32, paddingRight: 32)
        logoutButton.centerY(inView: self)
        logoutButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func handleLogout(){
        delegate?.handleLogout()
    }
}
