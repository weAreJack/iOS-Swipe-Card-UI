//
//  BottomControls.swift
//  swipe_card_UI
//
//  Created by Jack Smith on 26/08/2019.
//  Copyright © 2019 jack-adam-smith. All rights reserved.
//

import UIKit

class BottomControls: UIView {
    
    // MARK: - Properties
    
    let backButton = createButton(image: #imageLiteral(resourceName: "rewindButton"))
    let dislikeButton = createButton(image: #imageLiteral(resourceName: "dislikeButton"))
    let likeButton = createButton(image: #imageLiteral(resourceName: "like"))
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    fileprivate func setupUI() {
        addSubview(dislikeButton)
        addSubview(backButton)
        addSubview(likeButton)
        
        dislikeButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        dislikeButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        dislikeButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        dislikeButton.trailingAnchor.constraint(equalTo: backButton.leadingAnchor, constant: -32).isActive = true
        dislikeButton.layer.cornerRadius = 40

        backButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        backButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        backButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        backButton.layer.cornerRadius = 35

        likeButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        likeButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        likeButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        likeButton.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 32).isActive = true
        likeButton.layer.cornerRadius = 40
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    static func createButton(image: UIImage) -> UIButton {
        let button = BottomButton(type: .system)
        button.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }
    
}

