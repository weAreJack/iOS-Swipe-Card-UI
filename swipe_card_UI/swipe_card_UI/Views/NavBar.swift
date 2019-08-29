//
//  HomeNavBar.swift
//  swipe_card_UI
//
//  Created by Jack Smith on 26/08/2019.
//  Copyright © 2019 jack-adam-smith. All rights reserved.
//

import UIKit

class NavBar: UIView {
    
    // MARK: - Properties
    
    let icon = UIImageView(image: #imageLiteral(resourceName: "swipe_card_UI_icon"))
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    fileprivate func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        dropShadow()
        
        addSubview(icon)
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        icon.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 36).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 36).isActive = true
    }
    
}
