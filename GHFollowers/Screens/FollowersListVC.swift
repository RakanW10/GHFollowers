//
//  FollowersListVC.swift
//  GHFollowers
//
//  Created by Rakan Alotibi on 09/11/1445 AH.
//

import UIKit

class FollowersListVC: UIViewController {

    let username: String
    
    init(username: String) {
        self.username = username
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = false
        self.title = username
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
}
