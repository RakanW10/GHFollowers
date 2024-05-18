//
//  SearchVC.swift
//  GHFollowers
//
//  Created by Rakan Alotibi on 09/11/1445 AH.
//

import UIKit

class SearchVC: UIViewController {
    
    // MARK:  UIs
    private lazy var logoImageView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "gh-logo")
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    private lazy var usernameTextField = GFTextField()
    private lazy var callToActionButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
    
    // MARK:  Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configure()
        createDismissKeyboardTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    // MARK:  Configure
    private func configure() {
        view.addSubview(logoImageView)

        view.addSubview(usernameTextField)
        usernameTextField.delegate = self

        view.addSubview(callToActionButton)
        callToActionButton.addTarget(self, action: #selector(pushFollowersListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameTextField.heightAnchor.constraint(equalToConstant: 55),
            
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -48),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 55),

        ])
    }
    
    private func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc private func pushFollowersListVC() {
        if let username = usernameTextField.text,
           !username.isEmpty {
            let followersListVC = FollowersListVC(username: username)
            navigationController?.pushViewController(followersListVC, animated: true)
        } else {
            presentGFAlertOnMainThread(alertTitle: "Empty Username", message: "Please enter a username, We need to know who to look for 😊", buttonTitle: "Ok")
        }
        
    }

}

// MARK:  UITextFieldDelegate
extension SearchVC: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowersListVC()
        return true
    }
}
