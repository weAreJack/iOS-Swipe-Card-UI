//
//  UIView+ConvenienceContraints.swift
//  swipe_card_UI
//
//  Created by Jack Smith on 23/05/2020.
//  Copyright © 2020 jack-adam-smith. All rights reserved.
//

import UIKit

/// Keys used to access each NSLayoutConstraint returned by all methods in Programatic Constraints.
enum ConstraintKey {
    case LeadingConstraint
    case TrailingConstraint
    case TopConstraint
    case BottomConstraint
    
    case CenterXConstraint
    case CenterYConstraint
    
    case HeightConstraint
    case WidthConstraint
}

extension UIView {
    
    /// Adds NSLayoutConstraints that are equal to the view passed. All constraints are active by default. Note: sets translatesAutoresizingMaskIntoConstraints to false.
    /// - Parameter view: The view to constrain to.
    /// - Returns: Dictionary of contraints keyed by ConstraintKey.
    @discardableResult
    func constraintsEqual(toView view: UIView) -> [ConstraintKey: NSLayoutConstraint] {
        
        var constraints = [ConstraintKey: NSLayoutConstraint]()
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let leadingConstraint = self.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        constraints[ConstraintKey.LeadingConstraint] = leadingConstraint
        
        let topConstraint = self.topAnchor.constraint(equalTo: view.topAnchor)
        constraints[ConstraintKey.TopConstraint] = topConstraint
        
        let trailingConstraint = self.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        constraints[ConstraintKey.TrailingConstraint] = trailingConstraint
        
        let bottomConstraint = self.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        constraints[ConstraintKey.BottomConstraint] = bottomConstraint
        
        constraints.values.forEach {
            $0.isActive = true
        }
        
        return constraints
    }
    
    /// Adds NSLayoutConstraints that are equal to the view passed, with padding on all sides equal to the padding parameter passed. All constraints are active by default. Note: sets translatesAutoresizingMaskIntoConstraints to false.
    /// - Parameters:
    ///   - view: The view to constrain to.
    ///   - padding: The padding to apply.
    /// - Returns: Dictionary of contraints keyed by ConstraintKey.
    @discardableResult
    func constraintsEqual(toView view: UIView, withEqualPadding padding: CGFloat) -> [ConstraintKey: NSLayoutConstraint] {
        
        var constraints = [ConstraintKey: NSLayoutConstraint]()
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let leadingConstraint = self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding)
        constraints[ConstraintKey.LeadingConstraint] = leadingConstraint
        
        let topConstraint = self.topAnchor.constraint(equalTo: view.topAnchor, constant: padding)
        constraints[ConstraintKey.TopConstraint] = topConstraint
        
        let trailingConstraint = self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
        constraints[ConstraintKey.TrailingConstraint] = trailingConstraint
        
        let bottomConstraint = self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding)
        constraints[ConstraintKey.BottomConstraint] = bottomConstraint
        
        constraints.values.forEach {
            $0.isActive = true
        }
        
        return constraints
    }
    
    /// Adds NSLayoutConstraints that are equal to the view passed, with padding on all sides provided as edge insets. All constraints are active by default. Note: sets translatesAutoresizingMaskIntoConstraints to false.
    /// - Parameters:
    ///   - view: The view to constrain to.
    ///   - padding: The padding to apply.
    /// - Returns: Dictionary of contraints keyed by ConstraintKey.
    @discardableResult
    func constraintsEqual(toView view: UIView, withPadding padding: UIEdgeInsets) -> [ConstraintKey: NSLayoutConstraint] {
        
        var constraints = [ConstraintKey: NSLayoutConstraint]()
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let leadingConstraint = self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding.left)
        constraints[ConstraintKey.LeadingConstraint] = leadingConstraint
        
        let topConstraint = self.topAnchor.constraint(equalTo: view.topAnchor, constant: padding.top)
        constraints[ConstraintKey.TopConstraint] = topConstraint
        
        let trailingConstraint = self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding.right)
        constraints[ConstraintKey.TrailingConstraint] = trailingConstraint
        
        let bottomConstraint = self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding.bottom)
        constraints[ConstraintKey.BottomConstraint] = bottomConstraint
        
        constraints.values.forEach {
            $0.isActive = true
        }
        
        return constraints
    }
    
    /// Adds NSLayoutConstraints that are equal to the layout guide passed. All constraints are active by default. Note: sets translatesAutoresizingMaskIntoConstraints to false.
    /// - Parameter view: The view to constrain to.
    /// - Returns: Dictionary of contraints keyed by ConstraintKey.
    @discardableResult
    func constraintsEqual(toLayoutGuide layoutGuide: UILayoutGuide) -> [ConstraintKey: NSLayoutConstraint] {
        
        var constraints = [ConstraintKey: NSLayoutConstraint]()
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let leadingConstraint = self.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor)
        constraints[ConstraintKey.LeadingConstraint] = leadingConstraint
        
        let topConstraint = self.topAnchor.constraint(equalTo: layoutGuide.topAnchor)
        constraints[ConstraintKey.TopConstraint] = topConstraint
        
        let trailingConstraint = self.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor)
        constraints[ConstraintKey.TrailingConstraint] = trailingConstraint
        
        let bottomConstraint = self.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor)
        constraints[ConstraintKey.BottomConstraint] = bottomConstraint
        
        constraints.values.forEach {
            $0.isActive = true
        }
        
        return constraints
    }
    
    /// Adds NSLayoutConstraints that are equal to the layout guide passed, with padding on all sides equal to the padding parameter passed. All constraints are active by default. Note: sets translatesAutoresizingMaskIntoConstraints to false.
    /// - Parameters:
    ///   - view: The view to constrain to.
    ///   - padding: The padding to apply.
    /// - Returns: Dictionary of contraints keyed by ConstraintKey.
    @discardableResult
    func constraintsEqual(toLayoutGuide layoutGuide: UILayoutGuide, withEqualPadding padding: CGFloat) -> [ConstraintKey: NSLayoutConstraint] {
        
        var constraints = [ConstraintKey: NSLayoutConstraint]()
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let leadingConstraint = self.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: padding)
        constraints[ConstraintKey.LeadingConstraint] = leadingConstraint
        
        let topConstraint = self.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: padding)
        constraints[ConstraintKey.TopConstraint] = topConstraint
        
        let trailingConstraint = self.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -padding)
        constraints[ConstraintKey.TrailingConstraint] = trailingConstraint
        
        let bottomConstraint = self.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: -padding)
        constraints[ConstraintKey.BottomConstraint] = bottomConstraint
        
        constraints.values.forEach {
            $0.isActive = true
        }
        
        return constraints
    }
    
    /// Adds NSLayoutConstraints that are equal to the layout guide passed, with padding on all sides provided as edge insets. All constraints are active by default. Note: sets translatesAutoresizingMaskIntoConstraints to false.
    /// - Parameters:
    ///   - view: The view to constrain to.
    ///   - padding: The padding to apply.
    /// - Returns: Dictionary of contraints keyed by ConstraintKey.
    @discardableResult
    func constraintsEqual(toLayoutGuide layoutGuide: UILayoutGuide, withPadding padding: UIEdgeInsets) -> [ConstraintKey: NSLayoutConstraint] {
        
        var constraints = [ConstraintKey: NSLayoutConstraint]()
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let leadingConstraint = self.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: padding.left)
        constraints[ConstraintKey.LeadingConstraint] = leadingConstraint
        
        let topConstraint = self.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: padding.top)
        constraints[ConstraintKey.TopConstraint] = topConstraint
        
        let trailingConstraint = self.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -padding.right)
        constraints[ConstraintKey.TrailingConstraint] = trailingConstraint
        
        let bottomConstraint = self.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: -padding.bottom)
        constraints[ConstraintKey.BottomConstraint] = bottomConstraint
        
        constraints.values.forEach {
            $0.isActive = true
        }
        
        return constraints
    }
}
