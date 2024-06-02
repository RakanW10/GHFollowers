//
//  FavoriteCell.swift
//  GHFollowers
//
//  Created by Rakan Alotibi on 23/11/1445 AH.
//

import UIKit

class FavoriteCell: UITableViewCell {
    static let reuseID = "FavoriteCell"

    let avatarImageView = GFAvatarImageView(frame: .zero)
    let usernameLabel = GFTitleLabel(textAlignment: .left, fontSize: 26)

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: FavoriteCell.reuseID)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(favorite: Follower){
        usernameLabel.text = favorite.login
        avatarImageView.downloadImage(form: favorite.avatarUrl)
    }
    
    // MARK:  Configurations
    private func configure(){
        addSubview(avatarImageView)
        addSubview(usernameLabel)
        accessoryType = .disclosureIndicator
        
        let padding = 12.0
        
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            usernameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: padding * 2),
            usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    
}
