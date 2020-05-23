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
    ///   - topAnchor: The top anchor to anchor to.
    ///   - leadingAnchor: The leading anchor to anchor to.
    ///   - bottomAnchor: The bottom anchor to anchor to.
    ///   - trailingAnchor: The trailing anchor to anchor to.
    ///   - borderPadding: Padding to apply to each border.
    ///   - size: Size constants to apply to the view.
    /// - Returns: Dictionary of contraints keyed by ConstraintKey.
    @discardableResult
    func borderConstraints(topAnchor: NSLayoutYAxisAnchor? = nil,
                           leadingAnchor: NSLayoutXAxisAnchor? = nil,
                           bottomAnchor: NSLayoutYAxisAnchor? = nil,
                           trailingAnchor: NSLayoutXAxisAnchor? = nil,
                           size: CGSize? = nil) -> [ConstraintKey: NSLayoutConstraint] {
        
        var constraints = [ConstraintKey: NSLayoutConstraint]()
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let topAnchor = topAnchor {
            let topConstraint = self.topAnchor.constraint(equalTo: topAnchor)
            constraints[ConstraintKey.TopConstraint] = topConstraint
        }
        
        if let leadingAnchor = leadingAnchor {
            let leadingConstraint = self.leadingAnchor.constraint(equalTo: leadingAnchor)
            constraints[ConstraintKey.LeadingConstraint] = leadingConstraint
        }
        
        if let bottomAnchor = bottomAnchor {
            let bottomConstraint = self.bottomAnchor.constraint(equalTo: bottomAnchor)
            constraints[ConstraintKey.BottomConstraint] = bottomConstraint
        }
        
        if let trailingAnchor = trailingAnchor {
            let trailingConstraint = self.trailingAnchor.constraint(equalTo: trailingAnchor)
            constraints[ConstraintKey.TrailingConstraint] = trailingConstraint
        }
        
        if let size = size {
            if size.height != .zero {
                let heightConstraint = self.heightAnchor.constraint(equalToConstant: size.height)
                constraints[ConstraintKey.HeightConstraint] = heightConstraint
            }
            
            if size.width != .zero {
                let widthConstraint = self.widthAnchor.constraint(equalToConstant: size.width)
                constraints[ConstraintKey.WidthConstraint] = widthConstraint
            }
        }
        
        constraints.values.forEach {
            $0.isActive = true
        }
        
        return constraints
    }
    
    /// Adds NSLayoutConstraints. All constraints are active by default. All parameters have default values and can be excluded. Note: sets translatesAutoresizingMaskIntoConstraints to false.
    /// - Parameters:
    ///   - topAnchor: The top anchor to anchor to.
    ///   - leadingAnchor: The leading anchor to anchor to.
    ///   - bottomAnchor: The bottom anchor to anchor to.
    ///   - trailingAnchor: The trailing anchor to anchor to.
    ///   - borderPadding: Padding to apply to each border.
    ///   - size: Size constants to apply to the view.
    /// - Returns: Dictionary of contraints keyed by ConstraintKey.
    @discardableResult
    func borderConstraints(topAnchor: NSLayoutYAxisAnchor? = nil,
                           leadingAnchor: NSLayoutXAxisAnchor? = nil,
                           bottomAnchor: NSLayoutYAxisAnchor? = nil,
                           trailingAnchor: NSLayoutXAxisAnchor? = nil,
                           borderPadding: UIEdgeInsets = .init(top: .zero, left: .zero, bottom: .zero, right: .zero),
                           size: CGSize? = nil) -> [ConstraintKey: NSLayoutConstraint] {
        
        var constraints = [ConstraintKey: NSLayoutConstraint]()
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let topAnchor = topAnchor {
            let topConstraint = self.topAnchor.constraint(equalTo: topAnchor, constant: borderPadding.top)
            constraints[ConstraintKey.TopConstraint] = topConstraint
        }
        
        if let leadingAnchor = leadingAnchor {
            let leadingConstraint = self.leadingAnchor.constraint(equalTo: leadingAnchor, constant: borderPadding.left)
            constraints[ConstraintKey.LeadingConstraint] = leadingConstraint
        }
        
        if let bottomAnchor = bottomAnchor {
            let bottomConstraint = self.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -borderPadding.bottom)
            constraints[ConstraintKey.BottomConstraint] = bottomConstraint
        }
        
        if let trailingAnchor = trailingAnchor {
            let trailingConstraint = self.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -borderPadding.right)
            constraints[ConstraintKey.TrailingConstraint] = trailingConstraint
        }
        
        if let size = size {
            if size.height != .zero {
                let heightConstraint = self.heightAnchor.constraint(equalToConstant: size.height)
                constraints[ConstraintKey.HeightConstraint] = heightConstraint
            }
            
            if size.width != .zero {
                let widthConstraint = self.widthAnchor.constraint(equalToConstant: size.width)
                constraints[ConstraintKey.WidthConstraint] = widthConstraint
            }
        }
        
        constraints.values.forEach {
            $0.isActive = true
        }
        
        return constraints
    }
    
    /// Adds NSLayoutConstraints. All constraints are active by default. All parameters have default values and can be excluded. Note: sets translatesAutoresizingMaskIntoConstraints to false. 
    /// - Parameters:
    ///   - topAnchor: The top anchor to anchor to.
    ///   - leadingAnchor: The leading anchor to anchor to.
    ///   - bottomAnchor: The bottom anchor to anchor to.
    ///   - trailingAnchor: The trailing anchor to anchor to.
    ///   - borderPadding: Padding constant to apply to every border.
    ///   - size: Size constants to apply to the view.
    /// - Returns: Dictionary of contraints keyed by ConstraintKey.
    @discardableResult
    func borderConstraints(topAnchor: NSLayoutYAxisAnchor? = nil,
                           leadingAnchor: NSLayoutXAxisAnchor? = nil,
                           bottomAnchor: NSLayoutYAxisAnchor? = nil,
                           trailingAnchor: NSLayoutXAxisAnchor? = nil,
                           equalBorderPadding borderPadding: CGFloat = .zero,
                           size: CGSize? = nil) -> [ConstraintKey: NSLayoutConstraint] {
        
        var constraints = [ConstraintKey: NSLayoutConstraint]()
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let topAnchor = topAnchor {
            let topConstraint = self.topAnchor.constraint(equalTo: topAnchor, constant: borderPadding)
            constraints[ConstraintKey.TopConstraint] = topConstraint
        }
        
        if let leadingAnchor = leadingAnchor {
            let leadingConstraint = self.leadingAnchor.constraint(equalTo: leadingAnchor, constant: borderPadding)
            constraints[ConstraintKey.LeadingConstraint] = leadingConstraint
        }
        
        if let bottomAnchor = bottomAnchor {
            let bottomConstraint = self.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -borderPadding)
            constraints[ConstraintKey.BottomConstraint] = bottomConstraint
        }
        
        if let trailingAnchor = trailingAnchor {
            let trailingConstraint = self.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -borderPadding)
            constraints[ConstraintKey.TrailingConstraint] = trailingConstraint
        }
        
        if let size = size {
            if size.height != .zero {
                let heightConstraint = self.heightAnchor.constraint(equalToConstant: size.height)
                constraints[ConstraintKey.HeightConstraint] = heightConstraint
            }
            
            if size.width != .zero {
                let widthConstraint = self.widthAnchor.constraint(equalToConstant: size.width)
                constraints[ConstraintKey.WidthConstraint] = widthConstraint
            }
        }
        
        constraints.values.forEach {
            $0.isActive = true
        }
        
        return constraints
    }
}
