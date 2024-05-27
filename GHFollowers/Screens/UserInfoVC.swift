//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by Rakan Alotibi on 16/11/1445 AH.
//

import UIKit
import SafariServices

protocol UserInfoVCDelegate: AnyObject {
    func didTapGitHubProfile(for user: User)
    func didTapGetFollowers(for user: User)
}

class UserInfoVC: UIViewController {
    let username: String
    
    // MARK:  UIs
    private let headerView = UIView()
    private let itemViewOne = UIView()
    private let itemViewTwo = UIView()
    private let dateLabel = GFBodyLabel(textAlignment: .center)
    weak var delegate: FollowerListVCDelegate?
    
    init(username: String, delegate: FollowerListVCDelegate) {
        self.username = username
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init(coder: NSCoder) {fatalError()}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        getUserInfo()
    }
    
    
    // MARK:  Methods
    @objc private func dismissVC() {
        dismiss(animated: true)
    }
    
    private func add(childVC: UIViewController, to containerView: UIView){
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    private func getUserInfo() {
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let user):
                DispatchQueue.main.async { self.configureUIElements(with: user) }
                
            case .failure(let failure):
                presentGFAlertOnMainThread(alertTitle: "Something went wrong", message: failure.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    private func configureUIElements(with user: User){
        add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
        add(childVC: GFRepoItemVC(user: user, delegate: self), to: self.itemViewOne)
        add(childVC: GFFollowerItemVC(user: user, delegate: self ), to: self.itemViewTwo)
        dateLabel.text = "Github since \(user.createdAt.convertToDate?.convertToMonthYearFormat ?? "Unknown")"
    }
    
    // MARK:  Configuration
    private func configure(){
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
        
        [ headerView,
          itemViewOne,
          itemViewTwo,
          dateLabel
        ].forEach { item in
            view.addSubview(item)
            item.translatesAutoresizingMaskIntoConstraints = false
        }

        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            itemViewOne.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            itemViewTwo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 24),
        ])
    }
}

// MARK:  UserInfoVCDelegate
extension UserInfoVC: UserInfoVCDelegate{
    func didTapGitHubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertOnMainThread(alertTitle: "Invalid URL", message: "The url attached to this user is invalid.", buttonTitle: "Ok")
            return
        }
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }
    
    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else {
            presentGFAlertOnMainThread(alertTitle: "No followers", message: "The user has no followers. What a shame 😔", buttonTitle: "So bad")
            return
        }
        delegate?.shouldUpdateDate(with: user.login)
        dismissVC()
    }
}
