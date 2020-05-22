//
//  KeepSwipingButton.swift
//  swipe_card_UI
//
//  Created by Jack Smith on 26/08/2019.
//  Copyright © 2019 jack-adam-smith. All rights reserved.
//

import UIKit

class KeepSwipingButton: UIButton {
    
    // MARK: - Init
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupUI(rect)
    }
    
    // MARK: - Methods
    
    fileprivate func setupUI(_ rect: CGRect) {
        setTitle("Keep Swiping", for: .normal)
        setTitleColor(.white, for: .normal)
        
        let cornerRadius = rect.height/2
        let gradientLayer = CAGradientLayer()
        let leftColour = UIColor.colour1.cgColor
        let rightcolour = UIColor.colour2.cgColor
        
        gradientLayer.colors = [leftColour, rightcolour]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        
        let maskLayer = CAShapeLayer()
        let maskPath = CGMutablePath()
        maskPath.addPath(UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).cgPath)
        maskPath.addPath(UIBezierPath(roundedRect: rect.insetBy(dx: 2, dy: 2), cornerRadius: cornerRadius).cgPath)
        
        maskLayer.path = maskPath
        maskLayer.fillRule = .evenOdd
        gradientLayer.mask = maskLayer
        self.layer.insertSublayer(gradientLayer, at: 0)
        
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        gradientLayer.frame = rect
    }
    
}

