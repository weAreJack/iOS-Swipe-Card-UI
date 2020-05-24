//
//  UIViewController+StatusBarCover.swift
//  swipe_card_UI
//
//  Created by Jack Smith on 24/05/2020.
//  Copyright © 2020 jack-adam-smith. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func addStatusBarCover(colour: UIColor) {
        
        let statusBarCover = UIView()
        statusBarCover.backgroundColor = colour
        statusBarCover.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(statusBarCover)
        statusBarCover.borderConstraints(topAnchor: self.view.topAnchor,
                                         leadingAnchor: self.view.leadingAnchor,
                                         bottomAnchor: self.view.safeAreaLayoutGuide.topAnchor,
                                         trailingAnchor: self.view.trailingAnchor)
    }
}
