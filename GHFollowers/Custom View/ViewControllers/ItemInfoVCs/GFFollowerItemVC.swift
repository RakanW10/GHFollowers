//
//  GFFollowerItemVC.swift
//  GHFollowers
//
//  Created by Rakan Alotibi on 19/11/1445 AH.
//

import UIKit

class GFFollowerItemVC: GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure(){
        itemInfoViewOne.set(viewType: .followers, count: user.followers)
        itemInfoViewTwo.set(viewType: .following, count: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
    
    override func actionButtonTapped() {
        delegate?.didTapGetFollowers(for: user)
    }
}
