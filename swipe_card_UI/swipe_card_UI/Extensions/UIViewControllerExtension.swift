//
//  UIViewControllerExtension.swift
//  swipe_card_UI
//
//  Created by Jack Smith on 27/08/2019.
//  Copyright © 2019 jack-adam-smith. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func addStatusBarCover(colour: UIColor) {
        
        let statusBarCover = UIView()
        statusBarCover.backgroundColor = colour
        statusBarCover.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(statusBarCover)
        statusBarCover.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        statusBarCover.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        statusBarCover.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        statusBarCover.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
    }
    
}
