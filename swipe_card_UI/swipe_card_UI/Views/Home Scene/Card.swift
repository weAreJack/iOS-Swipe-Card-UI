//
//  Card.swift
//  swipe_card_UI
//
//  Created by Jack Smith on 26/08/2019.
//  Copyright © 2019 jack-adam-smith. All rights reserved.
//

import UIKit
import SDWebImage

protocol CardDelegate: class {
    func cardDidSwipeRight(card: Card)
    func cardDidSwipeLeft(card: Card)
}

class Card: UIView {
    
    // MARK: - Properties
    
    var viewModel: CardViewModel
    var nextCard: Card?
    weak var delegate: CardDelegate?
    
    private let imageView = UIImageView()
    private let informationLabel = UILabel()
    
    private let borderPadding: CGFloat = 16
    private let corderRadius: CGFloat = 25
    private let borderWidth: CGFloat = 4
    
    // MARK: - Init
    
    init(viewModel: CardViewModel) {
        
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        self.configureViews()
        self.layoutViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func layoutViews() {
        self.addSubview(self.imageView)
        self.imageView.constraintsEqual(toView: self)
        
        self.addSubview(self.informationLabel)
        self.informationLabel.borderConstraints(topAnchor: nil,
                                                leadingAnchor: self.leadingAnchor,
                                                bottomAnchor: self.bottomAnchor,
                                                trailingAnchor: self.trailingAnchor,
                                                equalBorderPadding: self.borderPadding)
    }
    
    private func configureViews() {
        self.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
        self.layer.cornerRadius = self.corderRadius
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = self.borderWidth
        self.clipsToBounds = true
        self.backgroundColor = self.viewModel.backgroundColour
        
        self.informationLabel.attributedText = self.viewModel.attributedIntro
        self.informationLabel.textAlignment = self.viewModel.textAlignment
        self.informationLabel.textColor = .white
        self.informationLabel.numberOfLines = .zero
        
        self.imageView.sd_imageIndicator = SDWebImageActivityIndicator.medium
        self.imageView.sd_setImage(with: self.viewModel.imageUrl, completed: nil)
        self.imageView.clipsToBounds = true
        self.imageView.contentMode = .scaleAspectFit
    }
    
    @objc
    private func handlePan(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            self.superview?.subviews.forEach({ (subView) in
                subView.layer.removeAllAnimations()
            })
        case .changed:
            self.handleChanged(gesture)
        case .ended:
            self.handleEnded(gesture)
        default:
            ()
        }
    }
    
    private func handleEnded(_ gesture: UIPanGestureRecognizer) {
        let swipeThreshold: CGFloat = 120
        let translationDirection: Int = gesture.translation(in: nil).x > .zero ? .one : -.one
        let shouldDismissCard = abs(gesture.translation(in: nil).x) > swipeThreshold
        if shouldDismissCard {
            self.handleSwiped(translationDirection)
        } else {
            self.animateToIdentity()
        }
    }
    
    private func handleSwiped(_ translationDirection: Int) {
        if translationDirection == .one {
            self.delegate?.cardDidSwipeRight(card: self)
        } else {
            self.delegate?.cardDidSwipeLeft(card: self)
        }
    }
    
    private func animateToIdentity() {
        let duration: Double = .one
        let delay: Double = .zero
        let springDamping: CGFloat = 0.6
        let springVelocity: CGFloat = 0.1
        
        UIView.animate(withDuration: duration,
                       delay: delay,
                       usingSpringWithDamping: springDamping,
                       initialSpringVelocity: springVelocity,
                       options: .curveEaseOut,
                       animations: {
                        
                        self.transform = .identity
        })
    }
    
    private func handleChanged(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: nil)
        let degrees: CGFloat = translation.x / 20
        let angle = degrees * .pi / 180
        let rotationalTransform = CGAffineTransform(rotationAngle: angle)
        self.transform = rotationalTransform.translatedBy(x: translation.x, y: translation.y)
    }
}
