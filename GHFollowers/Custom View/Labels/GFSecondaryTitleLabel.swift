//
//  GFSecondaryTitleLabel:.swift
//  GHFollowers
//
//  Created by Rakan Alotibi on 17/11/1445 AH.
//

import UIKit

class GFSecondaryTitleLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    // Storyboard initializer
    required init?(coder: NSCoder) {
        fatalError("Since we are not using story board init?(coder: NSCoder) not needed")
    }

    init(fontSize: CGFloat) {
        super.init(frame: .zero)
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
        configure()
    }
    
    
    private func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        textColor = .secondaryLabel
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail
    }
}
