//
//  GFTextField.swift
//  GHFollowers
//
//  Created by Rakan Alotibi on 09/11/1445 AH.
//

import UIKit

class GFTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    // Storyboard initializer
    required init?(coder: NSCoder) {
        fatalError("Since we are not using story board init?(coder: NSCoder) not needed")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray4.cgColor
        
        textColor = .label
        tintColor = .label
        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12
        
        backgroundColor = .tertiarySystemBackground
        autocorrectionType = .no
        returnKeyType = .go
        
        placeholder = "Enter a username"
        
    }
}
