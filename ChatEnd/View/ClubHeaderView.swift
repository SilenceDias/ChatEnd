//
//  ClubHeaderView.swift
//  ChatEnd
//
//  Created by Диас Мухамедрахимов on 23.05.2022.
//

import UIKit
import Firebase

protocol ClubHeaderDelegate: AnyObject{
    func dismissController()
}


class ClubHeaderView: UIView {
    var club: ClubModel?{
        didSet{ populateClubdata() }
    }
    weak var delegate: ClubHeaderDelegate?
    
    private let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "xMark"), for: .normal)
        button.imageView?.tintColor = .white
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        button.tintColor = .white
        button.imageView?.setDimensions(height: 22, width: 22)
        return button
    }()
    
    private let mainImageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.layer.borderColor = UIColor.white.cgColor
        image.layer.borderWidth = 4.0
        return image
    }()
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    private let address: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    @objc func handleDismiss(){
        delegate?.dismissController()
    }
    func populateClubdata(){
        guard let club = club else {return }
        nameLabel.text = club.name
        address.text = club.address
        guard let url = URL(string: club.imageMainUrl) else {return}
        mainImageView.sd_setImage(with: url)
    }
    func configureUi(){
        backgroundColor = .red
        mainImageView.setDimensions(height: 200, width: 400)
        mainImageView.layer.cornerRadius = 5
        addSubview(mainImageView)
        mainImageView.centerX(inView: self)
        mainImageView.anchor(top: topAnchor, paddingTop: 96)
        let stack = UIStackView(arrangedSubviews: [nameLabel,address])
        stack.axis = .vertical
        stack.spacing = 4
        addSubview(stack)
        stack.centerX(inView: self)
        stack.anchor(top: mainImageView.bottomAnchor, paddingTop: 16)
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



