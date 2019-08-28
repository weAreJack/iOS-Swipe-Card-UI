//
//  RoundedImageView.swift
//  swipe_card_UI
//
//  Created by Jack Smith on 28/08/2019.
//  Copyright © 2019 jack-adam-smith. All rights reserved.
//

import UIKit

class RoundedImageView : UIImageView {
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Handlers
    
    fileprivate func setupUI() {
        contentMode = .scaleAspectFit
        clipsToBounds = true
        layer.cornerRadius = 70
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
    }
}
