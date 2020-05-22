//
//  Card.swift
//  swipe_card_UI
//
//  Created by Jack Smith on 26/08/2019.
//  Copyright © 2019 jack-adam-smith. All rights reserved.
//

import UIKit

class Card : UIView {
    
    // MARK: - Properties
    
    var nextCardView : Card?    // Link to linked list
    var delegate : CardDelegate?
    var cardViewModel: CardViewModel! {
        didSet{
            imageView.backgroundColor = cardViewModel.backgroundColour
            informationLabel.attributedText = cardViewModel.attributedIntro
            informationLabel.textAlignment = cardViewModel.textAlignment
//            imageView.image = cardViewModel.image
        }
    }
    
    fileprivate var imageView = UIImageView()
    fileprivate let informationLabel = UILabel()
    fileprivate let swipeThreshold: CGFloat = 120
    
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
        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
        layer.cornerRadius = 25
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 4
        clipsToBounds = true
        
        addSubview(imageView)
        imageView.clipsToBounds = true
        imageView.fillSuperview()
        imageView.contentMode = .scaleAspectFit
        
        addSubview(informationLabel)
        informationLabel.translatesAutoresizingMaskIntoConstraints = false
        informationLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant:  16).isActive = true
        informationLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant:  -16).isActive = true
        informationLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant:  -16).isActive = true
        informationLabel.textColor = .white
        informationLabel.numberOfLines = 0
    }
    
    @objc fileprivate func handlePan(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            superview?.subviews.forEach({ (subView) in
                subView.layer.removeAllAnimations()
            })
        case .changed:
            handleChanged(gesture)
        case .ended:
            handleEnded(gesture)
        default:
            ()
        }
    }
    
    fileprivate func handleEnded(_ gesture: UIPanGestureRecognizer) {
        let translationDirection: CGFloat = gesture.translation(in: nil).x > 0 ? 1 : -1
        let shouldDismissCard = abs(gesture.translation(in: nil).x) > swipeThreshold
        if shouldDismissCard {
            if translationDirection == 1 {
                self.delegate?.handleLike()
            } else {
                self.delegate?.handleDislike()
            }
        } else {
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
                self.transform = .identity
            })
        }
    }
    
    fileprivate func handleChanged(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: nil)
        let degrees : CGFloat = translation.x / 20
        let angle = degrees * .pi / 180
        let rotationalTransform = CGAffineTransform(rotationAngle: angle)
        self.transform = rotationalTransform.translatedBy(x: translation.x, y: translation.y)
    }
    
}
