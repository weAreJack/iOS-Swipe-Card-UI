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
    
    private let icon = UIImageView(image: #imageLiteral(resourceName: "swipe_card_UI_icon"))
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layoutViews()
        self.configureViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func configureViews() {
        self.backgroundColor = .white
        self.dropShadow()
    }
    
    private func layoutViews() {
        let iconSize: CGFloat = 36
        
        self.addSubview(icon)
        self.icon.centeringConstraints(centerXAnchor: self.centerXAnchor,
                                       centerYAnchor: self.centerYAnchor,
                                       widthConstant: iconSize,
                                       heightConstant: iconSize)
    }
}
