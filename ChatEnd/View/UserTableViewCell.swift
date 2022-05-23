//
//  UserTableViewCell.swift
//  ChatEnd
//
//  Created by Диас Мухамедрахимов on 16.05.2022.
//

import UIKit
import SDWebImage

class UserTableViewCell: UITableViewCell {
    
    var club: ClubModel?{
        didSet {configure()}
    }
    
    private let profileImageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .systemBlue
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    private let fullnameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(profileImageView)
        profileImageView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 12)
        profileImageView.setDimensions(height: 64, width: 64)
        profileImageView.layer.cornerRadius = 64 / 2
        
        let stack = UIStackView(arrangedSubviews: [usernameLabel, fullnameLabel])
        stack.axis = .vertical
        stack.spacing = 2
        addSubview(stack)
        stack.centerY(inView: profileImageView, leftAnchor: profileImageView.rightAnchor, paddingLeft: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(){
        guard let club = club else {return }

        usernameLabel.text = club.name
        
        guard let url = URL(string: club.imageLogoUrl) else {return }
        profileImageView.sd_setImage(with: url)
    }
    
}
