//
//  UIViewController+Ext.swift
//  GHFollowers
//
//  Created by Rakan Alotibi on 09/11/1445 AH.
//

import UIKit

extension UIViewController {
    func presentGFAlertOnMainThread(alertTitle: String, message: String, buttonTitle: String){
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(alertTitle: alertTitle, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}
