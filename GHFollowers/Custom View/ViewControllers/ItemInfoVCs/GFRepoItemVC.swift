//
//  GFRepoItemVC.swift
//  GHFollowers
//
//  Created by Rakan Alotibi on 19/11/1445 AH.
//

import UIKit

class GFRepoItemVC: GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure(){
        itemInfoViewOne.set(viewType: .repo, count: user.publicRepos)
        itemInfoViewTwo.set(viewType: .gist, count: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "Github Profile")
    }
    
    override func actionButtonTapped() {
        delegate?.didTapGitHubProfile(for: user)
    }
}
