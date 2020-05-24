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
    
    weak var delegate: BottomControlsDelegate?
    
    private let height: CGFloat = 110
    private let padding: CGFloat = 32
    private let largeButtonSize: CGFloat = 80
    private let smallButtonSize: CGFloat = 70
    
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
        self.addSubview(self.backButton)
        self.backButton.centeringConstraints(centerXAnchor: self.centerXAnchor,
                                             centerYAnchor: self.centerYAnchor,
                                             widthConstant: self.smallButtonSize,
                                             heightConstant: self.smallButtonSize)
        self.backButton.roundCorners(radius: self.smallButtonSize / 2)
        
        self.addSubview(self.dislikeButton)
        self.dislikeButton.hybridConstraints(centerXAnchor: nil,
                                             centerYAnchor: self.centerYAnchor,
                                             topAnchor: nil,
                                             leadingAnchor: nil,
                                             bottomAnchor: nil,
                                             trailingAnchor: self.backButton.leadingAnchor,
                                             widthAnchor: nil,
                                             heightAnchor: nil,
                                             borderPadding: .init(top: .zero, left: .zero, bottom: .zero, right: self.padding),
                                             size: .init(width: self.largeButtonSize, height: self.largeButtonSize))
        self.dislikeButton.roundCorners(radius: self.largeButtonSize / 2)

        self.addSubview(self.likeButton)
        self.likeButton.hybridConstraints(centerXAnchor: nil,
                                          centerYAnchor: self.centerYAnchor,
                                          topAnchor: nil,
                                          leadingAnchor: self.backButton.trailingAnchor,
                                          bottomAnchor: nil,
                                          trailingAnchor: nil,
                                          widthAnchor: nil,
                                          heightAnchor: nil,
                                          borderPadding: .init(top: .zero, left: self.padding, bottom: .zero, right: .zero),
                                          size: .init(width: self.largeButtonSize, height: self.largeButtonSize))
        self.likeButton.roundCorners(radius: self.largeButtonSize / 2)
        
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
