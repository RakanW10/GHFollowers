//
//  GFItemInfoView.swift
//  GHFollowers
//
//  Created by Rakan Alotibi on 18/11/1445 AH.
//

import UIKit

class GFItemInfoView: UIView {
    enum ViewType {case repo, gist, following, followers}
    let titleLabel  = GFTitleLabel(textAlignment: .left,fontSize: 14)
    let countLabel  = GFTitleLabel(textAlignment: .center,fontSize: 14)
    let iconView    = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    func set(viewType: ViewType, count: Int){
        switch viewType {
        case .repo:
            titleLabel.text = "Public Repos"
            iconView.image = UIImage(systemName: SFSymbols.repos)
        case .gist:
            titleLabel.text = "Public Gists"
            iconView.image = UIImage(systemName: SFSymbols.gists)
        case .following:
            titleLabel.text = "Following"
            iconView.image = UIImage(systemName: SFSymbols.following)
        case .followers:
            titleLabel.text = "Followers"
            iconView.image = UIImage(systemName: SFSymbols.followers)
        }
        iconView.tintColor = .label
        countLabel.text = count.description
    }
    
    private func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        iconView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        addSubview(iconView)
        addSubview(countLabel)
        let padding : CGFloat = 8
        
        NSLayoutConstraint.activate([
            iconView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            iconView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            iconView.heightAnchor.constraint(equalToConstant: 20),
            iconView.widthAnchor.constraint(equalToConstant: 20),
            
            titleLabel.topAnchor.constraint(equalTo: iconView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
            
            
            countLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            countLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            countLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            countLabel.heightAnchor.constraint(equalToConstant: 18),
        ])
    }

}
