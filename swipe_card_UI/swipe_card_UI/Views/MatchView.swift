//
//  MatchView.swift
//  swipe_card_UI
//
//  Created by Jack Smith on 26/08/2019.
//  Copyright © 2019 jack-adam-smith. All rights reserved.
//

import UIKit

class MatchView: UIView {
    
    // MARK: - Properties

    var delegate : MatchViewDelegate?
    var viewModel : MatchedViewModel? {
        didSet {
            currentUserImageView.image = viewModel?.currentUserImage
            currentUserImageView.backgroundColor = viewModel?.currentUserBackgroundColour
            matchedCardImageView.image = viewModel?.matchedCardImage
            matchedCardImageView.backgroundColor = viewModel?.matchedCardBackgroundColour
        }
    }

    fileprivate let itsAMatchImageView = UIImageView(image: #imageLiteral(resourceName: "itsamatch"))
    fileprivate let descriptionLabel = UILabel()
    fileprivate let keepSwipingButton = KeepSwipingButton(type: .system)
    fileprivate let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    fileprivate let currentUserImageView = RoundedImageView(frame: CGRect())
    fileprivate let matchedCardImageView = RoundedImageView(frame: CGRect())

    lazy var views = [
        itsAMatchImageView,
        descriptionLabel,
        currentUserImageView,
        matchedCardImageView,
        keepSwipingButton
    ]

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBlurView()
        setupUI()
        setupAnimations()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Handlers

    fileprivate func setupUI() {

        // Initially views are invisible
        views.forEach { (v) in
            v.translatesAutoresizingMaskIntoConstraints = false
            addSubview(v)
            v.alpha = 0
        }

        let imageWidth : CGFloat = 140
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .white
        descriptionLabel.textAlignment = .center
        descriptionLabel.text = "You have a new match, view their profile to chat or purchase, or tap the keep swiping button to continue!"
        
        itsAMatchImageView.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -16).isActive = true
        itsAMatchImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        itsAMatchImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        itsAMatchImageView.widthAnchor.constraint(equalToConstant: 300).isActive = true

        descriptionLabel.bottomAnchor.constraint(equalTo: currentUserImageView.topAnchor, constant: -32).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32).isActive = true
        descriptionLabel.heightAnchor.constraint(equalToConstant: 75).isActive = true
        
        currentUserImageView.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -16).isActive = true
        currentUserImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 48).isActive = true
        currentUserImageView.heightAnchor.constraint(equalToConstant: imageWidth).isActive = true
        currentUserImageView.widthAnchor.constraint(equalToConstant: imageWidth).isActive = true
        
        matchedCardImageView.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 16).isActive = true
        matchedCardImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 48).isActive = true
        matchedCardImageView.heightAnchor.constraint(equalToConstant: imageWidth).isActive = true
        matchedCardImageView.widthAnchor.constraint(equalToConstant: imageWidth).isActive = true

        keepSwipingButton.topAnchor.constraint(equalTo: matchedCardImageView.bottomAnchor, constant: 32).isActive = true
        keepSwipingButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        keepSwipingButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        keepSwipingButton.widthAnchor.constraint(equalToConstant: 250).isActive = true
        
        keepSwipingButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)

    }

    fileprivate func setupAnimations() {

        views.forEach({$0.alpha = 1})
        let angle = 30 * CGFloat.pi/180

        currentUserImageView.transform = CGAffineTransform(rotationAngle: angle).concatenating(CGAffineTransform(translationX: 400, y: 0))
        matchedCardImageView.transform = CGAffineTransform(rotationAngle: -angle).concatenating(CGAffineTransform(translationX: -400, y: 0))
        keepSwipingButton.transform = CGAffineTransform(translationX: 500, y: 0)

        UIView.animateKeyframes(withDuration: 1.2, delay: 0, options: .calculationModeCubic, animations: {

            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                self.currentUserImageView.transform = CGAffineTransform(rotationAngle: angle)
                self.matchedCardImageView.transform = CGAffineTransform(rotationAngle: -angle)
            })

            UIView.addKeyframe(withRelativeStartTime: 0.7, relativeDuration: 0.5, animations: {
                self.currentUserImageView.transform = .identity
                self.matchedCardImageView.transform = .identity

            })
        }) { (_) in

        }

        UIView.animate(withDuration: 0.5, delay: 0.7, usingSpringWithDamping: 0.25, initialSpringVelocity: 0.3, options: .curveEaseOut, animations: {
            self.keepSwipingButton.transform = .identity
        }) { (_) in

        }
    }

    fileprivate func setupBlurView() {

        self.alpha = 0
        visualEffectView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))

        addSubview(visualEffectView)
        visualEffectView.fillSuperview()

        UIView.animate(withDuration: 1, delay: 0.2, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.alpha = 1
        }) { (_) in

        }
    }

    @objc fileprivate func handleDismiss() {
        self.delegate?.didDismissMatchView()
        UIView.animate(withDuration: 1, delay: 0.2, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.alpha = 0
        }) { (_) in
            self.removeFromSuperview()
        }
    }
    
}

