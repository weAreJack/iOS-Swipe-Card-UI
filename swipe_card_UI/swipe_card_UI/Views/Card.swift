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
    
    private let swipeThreshold: CGFloat = 120
    
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
    
    fileprivate func layoutViews() {
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
    
    private func configureViews() {
        self.imageView.backgroundColor = self.viewModel.backgroundColour
        self.informationLabel.attributedText = self.viewModel.attributedIntro
        self.informationLabel.textAlignment = self.viewModel.textAlignment
        self.imageView.sd_setImage(with: URL(string: self.viewModel.imageUrl), completed: nil)
    }
    
    @objc
    private func handlePan(gesture: UIPanGestureRecognizer) {
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
    
    private func handleEnded(_ gesture: UIPanGestureRecognizer) {
        let translationDirection: CGFloat = gesture.translation(in: nil).x > 0 ? 1 : -1
        let shouldDismissCard = abs(gesture.translation(in: nil).x) > swipeThreshold
        if shouldDismissCard {
            
            if translationDirection == 1 {
                self.delegate?.cardDidSwipeRight(card: self)
            } else {
                self.delegate?.cardDidSwipeLeft(card: self)
            }
            
        } else {
            
            UIView.animate(withDuration: 1,
                           delay: 0,
                           usingSpringWithDamping: 0.6,
                           initialSpringVelocity: 0.1,
                           options: .curveEaseOut,
                           animations: {
                self.transform = .identity
            })
            
        }
    }
    
    private func handleChanged(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: nil)
        let degrees : CGFloat = translation.x / 20
        let angle = degrees * .pi / 180
        let rotationalTransform = CGAffineTransform(rotationAngle: angle)
        self.transform = rotationalTransform.translatedBy(x: translation.x, y: translation.y)
    }
}
