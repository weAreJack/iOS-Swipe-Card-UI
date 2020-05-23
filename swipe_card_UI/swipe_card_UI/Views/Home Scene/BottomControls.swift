//
//  BottomControls.swift
//  swipe_card_UI
//
//  Created by Jack Smith on 26/08/2019.
//  Copyright © 2019 jack-adam-smith. All rights reserved.
//

import UIKit

protocol BottomControlsDelegate: class {
    func bottomControlsDidTapBackButton(bottomControls: BottomControls)
    func bottomControlsDidTapDislikeButton(bottomControls: BottomControls)
    func bottomControlsDidTapLikeButton(bottomControls: BottomControls)
}

class BottomControls: UIView {
    
    // MARK: - Properties
    
    private let backButton = BottomButton(image: #imageLiteral(resourceName: "rewindButton"), tintColour: .black)
    private let dislikeButton = BottomButton(image: #imageLiteral(resourceName: "dislikeButton"), tintColour: .red)
    private let likeButton = BottomButton(image: #imageLiteral(resourceName: "like"), tintColour: .colour5)
    
    private let height: CGFloat = 110
    weak var delegate: BottomControlsDelegate?
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addButtonTargets()
        self.layoutViews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func addButtonTargets() {
        self.backButton.addTarget(self, action: #selector(self.handleBackButtonTapped), for: .touchUpInside)
        self.likeButton.addTarget(self, action: #selector(self.handleLikeButtonTapped), for: .touchUpInside)
        self.dislikeButton.addTarget(self, action: #selector(self.handleDislikeButtonTapped), for: .touchUpInside)
    }
    
    private func layoutViews() {
        let padding: CGFloat = 32
        let largeButtonSize: CGFloat = 80
        let smallButtonSize: CGFloat = 70
        
        self.addSubview(self.backButton)
        self.backButton.centeringConstraints(centerXAnchor: self.centerXAnchor,
                                             centerYAnchor: self.centerYAnchor,
                                             widthConstant: smallButtonSize,
                                             heightConstant: smallButtonSize)
        self.backButton.roundCorners(radius: smallButtonSize / 2)
        
        self.addSubview(self.dislikeButton)
        self.dislikeButton.constraints(centerYAnchor: centerYAnchor,
                                       trailingAnchor: self.backButton.leadingAnchor,
                                       borderPadding: .init(top: .zero, left: .zero, bottom: .zero, right: padding),
                                       size: .init(width: largeButtonSize, height: largeButtonSize))
        self.dislikeButton.roundCorners(radius: largeButtonSize / 2)

        self.addSubview(self.likeButton)
        self.likeButton.constraints(centerYAnchor: centerYAnchor,
                                    leadingAnchor: self.backButton.trailingAnchor,
                                    borderPadding: .init(top: .zero, left: padding, bottom: .zero, right: .zero),
                                    size: .init(width: largeButtonSize, height: largeButtonSize))
        self.likeButton.roundCorners(radius: largeButtonSize / 2)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: self.height).isActive = true
    }
    
    @objc
    private func handleBackButtonTapped() {
        self.delegate?.bottomControlsDidTapBackButton(bottomControls: self)
    }
    
    @objc
    private func handleDislikeButtonTapped() {
        self.delegate?.bottomControlsDidTapDislikeButton(bottomControls: self)
    }
    
    @objc
    private func handleLikeButtonTapped() {
        self.delegate?.bottomControlsDidTapLikeButton(bottomControls: self)
    }
}
