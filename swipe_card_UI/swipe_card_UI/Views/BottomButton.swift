//
//  BottomButton.swift
//  swipe_card_UI
//
//  Created by Jack Smith on 26/08/2019.
//  Copyright © 2019 jack-adam-smith. All rights reserved.
//

import UIKit

class BottomButton : UIButton {
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    fileprivate func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .init(white: 0, alpha: 0.025)
        clipsToBounds = true
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 2
        imageView?.contentMode = .scaleAspectFill
        dropShadow()
    }
}
