//
//  FollowerCell.swift
//  GHFollowers
//
//  Created by Rakan Alotibi on 11/11/1445 AH.
//

import UIKit

class FollowerCell: UICollectionViewCell{
    static let reuseID = "FollowerCell"
    
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let usernameLabel = GFTitleLabel(textAlignment: .center, fontSize: 16)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    // Storyboard initializer
    required init?(coder: NSCoder) {
        fatalError("Since we are not using story board init?(coder: NSCoder) not needed")
    }
    
    func set(follower: Follower){
        usernameLabel.text = follower.login
        avatarImageView.downloadImage(form: follower.avatarUrl)
    }
    
    // MARK:  Configurations
    private func configure(){
        addSubview(avatarImageView)
        addSubview(usernameLabel)
        
        let padding = 8.0
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            usernameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    
}
