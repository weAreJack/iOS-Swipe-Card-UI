//
//  BottomButton.swift
//  swipe_card_UI
//
//  Created by Jack Smith on 26/08/2019.
//  Copyright © 2019 jack-adam-smith. All rights reserved.
//

import UIKit

class BottomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        self.backgroundColor = .init(white: .zero, alpha: 0.025)
        self.imageView?.contentMode = .scaleAspectFill
        self.clipsToBounds = true
        
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 2
    }
    
    func roundCorners(radius: CGFloat) {
        self.layer.cornerRadius = radius
    }
}
