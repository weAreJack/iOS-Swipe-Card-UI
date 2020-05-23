//
//  CircularImageView.swift
//  swipe_card_UI
//
//  Created by Jack Smith on 28/08/2019.
//  Copyright © 2019 jack-adam-smith. All rights reserved.
//

import UIKit

class CircularImageView: UIImageView {
    
    override func layoutSubviews() {
        self.layoutView()
    }
    
    private func layoutView() {
        self.contentMode = .scaleAspectFit
        self.clipsToBounds = true
        
        self.layer.cornerRadius = self.frame.width/2
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.white.cgColor
    }
}
