//
//  UIView+AddConstraints.swift
//  swipe_card_UI
//
//  Created by Jack Smith on 23/05/2020.
//  Copyright © 2020 jack-adam-smith. All rights reserved.
//

import UIKit

extension UIView {
    
    /// Adds NSLayoutConstraints. All constraints are active by default. All parameters have default values and can be excluded. Note: sets translatesAutoresizingMaskIntoConstraints to false.
    /// - Parameters:
    ///   - centerXAnchor: The X axis anchor to center on.
    ///   - centerYAnchor: The Y axis anchor to center on.
    ///   - widthConstant: The width constant to apply.
    ///   - heightConstant: The height constant to apply.
    ///   - positionConstants: Constants to apply to the x and y position.
    /// - Returns: Dictionary of contraints keyed by ConstraintKey.
    @discardableResult
    func centeringConstraints(centerXAnchor: NSLayoutXAxisAnchor? = nil,
                              centerYAnchor: NSLayoutYAxisAnchor? = nil,
                              widthConstant: CGFloat? = nil,
                              heightConstant: CGFloat? = nil,
                              positionConstants: CGPoint = .init(x: CGFloat.zero, y: CGFloat.zero)) -> [ConstraintKey: NSLayoutConstraint] {
        
        var constraints = [ConstraintKey: NSLayoutConstraint]()
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let centerXAnchor = centerXAnchor {
            let centerXConstraint = self.centerXAnchor.constraint(equalTo: centerXAnchor, constant: positionConstants.x)
            constraints[ConstraintKey.CenterXConstraint] = centerXConstraint
        }
        
        if let centerYAnchor = centerYAnchor {
            let centerYConstraint = self.centerYAnchor.constraint(equalTo: centerYAnchor, constant: positionConstants.y)
            constraints[ConstraintKey.CenterYConstraint] = centerYConstraint
        }
        
        if let widthConstant = widthConstant {
            let widthConstraint = self.widthAnchor.constraint(equalToConstant: widthConstant)
            constraints[ConstraintKey.WidthConstraint] = widthConstraint
        }
        
        if let heightConstant = heightConstant {
            let heightConstraint = self.heightAnchor.constraint(equalToConstant: heightConstant)
            constraints[ConstraintKey.HeightConstraint] = heightConstraint
        }
        
        constraints.values.forEach {
            $0.isActive = true
        }
        
        return constraints
    }
    
    /// Adds NSLayoutConstraints. All constraints are active by default. All parameters have default values and can be excluded. Note: sets translatesAutoresizingMaskIntoConstraints to false. 
    /// - Parameters:
    ///   - centerXAnchor: The X axis anchor to center on.
    ///   - centerYAnchor: The Y axis anchor to center on.
    ///   - widthAnchor: The width anchor to equal.
    ///   - heightAnchor: The height anchor to equal.
    ///   - positionConstants: Constants to apply to the x and y position.
    ///   - sizeConstants: Constants to apply to the width and height of the view.
    /// - Returns: Dictionary of contraints keyed by ConstraintKey.
    @discardableResult
    func centeringConstraints(centerXAnchor: NSLayoutXAxisAnchor? = nil,
                              centerYAnchor: NSLayoutYAxisAnchor? = nil,
                              widthAnchor: NSLayoutDimension? = nil,
                              heightAnchor: NSLayoutDimension? = nil,
                              positionConstants: CGPoint = .init(x: CGFloat.zero, y: CGFloat.zero),
                              sizeConstants: CGSize = .init(width: CGFloat.zero, height: CGFloat.zero)) -> [ConstraintKey: NSLayoutConstraint] {
        
        var constraints = [ConstraintKey: NSLayoutConstraint]()
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let centerXAnchor = centerXAnchor {
            let centerXConstraint = self.centerXAnchor.constraint(equalTo: centerXAnchor, constant: positionConstants.x)
            centerXConstraint.constant = positionConstants.x
            constraints[ConstraintKey.CenterXConstraint] = centerXConstraint
        }
        
        if let centerYAnchor = centerYAnchor {
            let centerYConstraint = self.centerYAnchor.constraint(equalTo: centerYAnchor, constant: positionConstants.y)
            centerYConstraint.constant = positionConstants.y
            constraints[ConstraintKey.CenterYConstraint] = centerYConstraint
        }
        
        if let widthAnchor = widthAnchor {
            let widthConstraint = self.widthAnchor.constraint(equalTo: widthAnchor, constant: sizeConstants.width)
            constraints[ConstraintKey.WidthConstraint] = widthConstraint
        }
        
        if let heightAnchor = heightAnchor {
            let heightConstraint = self.heightAnchor.constraint(equalTo: heightAnchor, constant: sizeConstants.height)
            constraints[ConstraintKey.HeightConstraint] = heightConstraint
        }
        
        constraints.values.forEach {
            $0.isActive = true
        }
        
        return constraints
    }
    
    /// Adds NSLayoutConstraints. All constraints are active by default. All parameters have default values and can be excluded. Note: sets translatesAutoresizingMaskIntoConstraints to false. 
    /// - Parameters:
    ///   - centerXAnchor: The X axis anchor to center on.
    ///   - centerYAnchor: The Y axis anchor to center on.
    ///   - widthAnchor: The width anchor to equal.
    ///   - heightAnchor: The height anchor to equal.
    ///   - positionConstants: Constants to apply to the x and y position.
    ///   - sizeMultipliers: Multipliers to apply to the width and height of the view.
    /// - Returns: Dictionary of contraints keyed by ConstraintKey.
    @discardableResult
    func centeringConstraints(centerXAnchor: NSLayoutXAxisAnchor? = nil,
                              centerYAnchor: NSLayoutYAxisAnchor? = nil,
                              widthAnchor: NSLayoutDimension? = nil,
                              heightAnchor: NSLayoutDimension? = nil,
                              positionConstants: CGPoint = .init(x: CGFloat.zero, y: CGFloat.zero),
                              sizeMultipliers: CGSize = .init(width: CGFloat.zero, height: CGFloat.zero)) -> [ConstraintKey: NSLayoutConstraint] {
        
        var constraints = [ConstraintKey: NSLayoutConstraint]()
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let centerXAnchor = centerXAnchor {
            let centerXConstraint = self.centerXAnchor.constraint(equalTo: centerXAnchor, constant: positionConstants.x)
            constraints[ConstraintKey.CenterXConstraint] = centerXConstraint
        }
        
        if let centerYAnchor = centerYAnchor {
            let centerYConstraint = self.centerYAnchor.constraint(equalTo: centerYAnchor, constant: positionConstants.y)
            constraints[ConstraintKey.CenterYConstraint] = centerYConstraint
        }
        
        if let widthAnchor = widthAnchor {
            let widthConstraint = self.widthAnchor.constraint(equalTo: widthAnchor, multiplier: sizeMultipliers.width)
            constraints[ConstraintKey.WidthConstraint] = widthConstraint
        }
        
        if let heightAnchor = heightAnchor {
            let heightConstraint = self.heightAnchor.constraint(equalTo: heightAnchor, multiplier: sizeMultipliers.height)
            constraints[ConstraintKey.HeightConstraint] = heightConstraint
        }
        
        constraints.values.forEach {
            $0.isActive = true
        }
        
        return constraints
    }
}
