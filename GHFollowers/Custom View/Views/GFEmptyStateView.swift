//
//  GFEmptyStateView.swift
//  GHFollowers
//
//  Created by Rakan Alotibi on 16/11/1445 AH.
//

import UIKit

class GFEmptyStateView: UIView {
    
    // MARK:  UIs
    private lazy var messageLabel: GFTitleLabel = {
        let msgLabel = GFTitleLabel(textAlignment: .center, fontSize: 28)
        msgLabel.numberOfLines = 3
        msgLabel.textColor = .secondaryLabel
        msgLabel.translatesAutoresizingMaskIntoConstraints = false
        return msgLabel
    }()
    
    private lazy var logoImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named:"empty-state-logo")
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.clipsToBounds = true
        imgView.sizeToFit()
        return imgView
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    // Storyboard initializer
    required init?(coder: NSCoder) {
        fatalError("Since we are not using story board init?(coder: NSCoder) not needed")
    }
    
    init(message: String) {
        super.init(frame: .zero)
        messageLabel.text = message
        configure()
    }
    
    // MARK:  Configuration
    private func configure(){
        addSubview(logoImageView)
        addSubview(messageLabel)
                
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            logoImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
            logoImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
            logoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: logoImageView.bounds.width / 2.5),
            logoImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: logoImageView.bounds.height / 5)
        ])
    }
    
    
}

