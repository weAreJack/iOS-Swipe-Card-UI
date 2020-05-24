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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.layoutView(rect)
    }
    
    // MARK: - Methods
    
    private func configureViews() {
        self.setTitle("Keep Swiping", for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.clipsToBounds = true
    }
    
    private func layoutView(_ rect: CGRect) {
        let cornerRadius = rect.height / 2
        self.layer.cornerRadius = cornerRadius
        
         self.addGradientLayer(rect, cornerRadius)
    }
    
    private func addGradientLayer(_ rect: CGRect, _ cornerRadius: CGFloat) {
        let gradientLayer = CAGradientLayer()
        let leftColour = UIColor.colour1.cgColor
        let rightcolour = UIColor.colour2.cgColor
        
        gradientLayer.colors = [leftColour, rightcolour]
        gradientLayer.startPoint = CGPoint(x: .zero, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        
        let maskLayer = CAShapeLayer()
        let maskPath = CGMutablePath()
        maskPath.addPath(UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).cgPath)
        maskPath.addPath(UIBezierPath(roundedRect: rect.insetBy(dx: 2, dy: 2), cornerRadius: cornerRadius).cgPath)
        
        maskLayer.path = maskPath
        maskLayer.fillRule = .evenOdd
        gradientLayer.mask = maskLayer
        self.layer.insertSublayer(gradientLayer, at: .zero)
        
        gradientLayer.frame = rect
    }
}
