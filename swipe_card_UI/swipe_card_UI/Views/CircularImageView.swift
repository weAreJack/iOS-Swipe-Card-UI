//
//  CircularImageView.swift
//  swipe_card_UI
//
//  Created by Jack Smith on 28/08/2019.
//  Copyright © 2019 jack-adam-smith. All rights reserved.
//

import UIKit

class CircularImageView: UIImageView {
    
    override func didMoveToSuperview() {
        self.layoutView()
    }
    
    private func layoutView() {
        contentMode = .scaleAspectFit
        clipsToBounds = true
        layer.cornerRadius = self.frame.width/2
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
    }
}
