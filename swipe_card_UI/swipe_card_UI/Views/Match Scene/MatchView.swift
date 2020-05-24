//
//  MatchView.swift
//  swipe_card_UI
//
//  Created by Jack Smith on 26/08/2019.
//  Copyright © 2019 jack-adam-smith. All rights reserved.
//

import UIKit
import SDWebImage

protocol MatchViewDelegate: class {
    func matchViewDidDismissMatchView(matchView: MatchView)
}

class MatchView: UIView {
    
    // MARK: - Properties

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        label.textColor = .white
        label.textAlignment = .center
        label.text = "You have a new match, view their profile to chat and purchase, or tap the keep swiping button to continue!"
        return label
    }()
    
    private let itsAMatchImageView = UIImageView(image: #imageLiteral(resourceName: "its_a_match_view"))
    private let keepSwipingButton = KeepSwipingButton(type: .system)
    private let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    private let currentUserImageView = CircularImageView(frame: CGRect())
    private let matchedCardImageView = CircularImageView(frame: CGRect())

    private lazy var views = [
        self.itsAMatchImageView,
        self.descriptionLabel,
        self.currentUserImageView,
        self.matchedCardImageView,
        self.keepSwipingButton
    ]
    
    private var viewModel: MatchedViewModel
    weak var delegate: MatchViewDelegate?
    
    private let fadeDuration: Double = 1
    private let fadeDelay: Double = 0.2
    private let fadeSpringDamping: CGFloat = 1
    private let fadeSpringVelocity: CGFloat = 1
    
    // MARK: - Init
    
    init(viewModel: MatchedViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        self.configureViews()
        self.layoutViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViews() {
        self.currentUserImageView.sd_imageIndicator = SDWebImageActivityIndicator.medium
        self.currentUserImageView.sd_setImage(with: self.viewModel.currentUserImageUrl, completed: nil)
        self.currentUserImageView.backgroundColor = viewModel.currentUserBackgroundColour
        
        self.matchedCardImageView.sd_imageIndicator = SDWebImageActivityIndicator.medium
        self.matchedCardImageView.sd_setImage(with: self.viewModel.matchedCardImageUrl, completed: nil)
        self.matchedCardImageView.backgroundColor = viewModel.matchedCardBackgroundColour
        
        self.keepSwipingButton.addTarget(self, action: #selector(self.handleDismiss), for: .touchUpInside)
        
        self.animateAddBlurView()
        self.startMainAnimations()
    }
    
    func layoutViews() {
        let itsaMatchSize = CGSize(width: 300, height: 80)
        let descriptionLabelSize = CGSize(width: .zero, height: 75)
        let keepSwipingButtonSize = CGSize(width: 300, height: 60)
        let postImageWidth: CGFloat = 140
        let standardPadding: CGFloat = 16
        
        self.views.forEach {
            self.addSubview($0)
        }
        
        self.itsAMatchImageView.hybridConstraints(centerXAnchor: self.centerXAnchor,
                                                  centerYAnchor: nil,
                                                  topAnchor: nil,
                                                  leadingAnchor: nil,
                                                  bottomAnchor: self.descriptionLabel.topAnchor,
                                                  trailingAnchor: nil,
                                                  widthAnchor: nil,
                                                  heightAnchor: nil,
                                                  borderPadding: .init(top: .zero, left: .zero, bottom: 16, right: .zero),
                                                  size: itsaMatchSize)
        
        self.descriptionLabel.borderConstraints(topAnchor: nil,
                                                leadingAnchor: self.leadingAnchor,
                                                bottomAnchor: self.currentUserImageView.topAnchor,
                                                trailingAnchor: self.trailingAnchor,
                                                equalBorderPadding: standardPadding * 2,
                                                size: descriptionLabelSize)
        
        self.currentUserImageView.hybridConstraints(centerXAnchor: self.centerXAnchor,
                                                    centerYAnchor: self.centerYAnchor,
                                                    topAnchor: nil,
                                                    leadingAnchor: nil,
                                                    bottomAnchor: self.descriptionLabel.topAnchor,
                                                    trailingAnchor: nil,
                                                    widthAnchor: nil,
                                                    heightAnchor: nil,
                                                    positionConstants: .init(x: .zero, y: standardPadding * 3),
                                                    borderPadding: .init(top: .zero, left: .zero, bottom: .zero, right: standardPadding),
                                                    size: .init(width: postImageWidth, height: postImageWidth))
        
        self.matchedCardImageView.hybridConstraints(centerXAnchor: self.centerXAnchor,
                                                    centerYAnchor: self.centerYAnchor,
                                                    topAnchor: nil,
                                                    leadingAnchor: nil,
                                                    bottomAnchor: self.descriptionLabel.topAnchor,
                                                    trailingAnchor: nil,
                                                    widthAnchor: nil,
                                                    heightAnchor: nil,
                                                    positionConstants: .init(x: .zero, y: standardPadding * 3),
                                                    borderPadding: .init(top: .zero, left: standardPadding, bottom: .zero, right: .zero),
                                                    size: .init(width: postImageWidth, height: postImageWidth))

        self.keepSwipingButton.hybridConstraints(centerXAnchor: self.centerXAnchor,
                                                 centerYAnchor: nil,
                                                 topAnchor: self.matchedCardImageView.bottomAnchor,
                                                 leadingAnchor: nil,
                                                 bottomAnchor: self.descriptionLabel.topAnchor,
                                                 trailingAnchor: nil,
                                                 widthAnchor: nil,
                                                 heightAnchor: nil,
                                                 borderPadding: .init(top: standardPadding * 2, left: .zero, bottom: .zero, right: .zero),
                                                 size: keepSwipingButtonSize)
    }
    
    private func animateAddBlurView() {
        self.alpha = .zero
        self.visualEffectView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleDismiss)))
        
        self.addSubview(self.visualEffectView)
        self.visualEffectView.constraintsEqual(toView: self)
        
        self.animateFadeIn()
    }
    
    private func animateFadeIn() {
        UIView.animate(withDuration: self.fadeDuration,
                       delay: self.fadeDelay,
                       usingSpringWithDamping: self.fadeSpringDamping,
                       initialSpringVelocity: self.fadeSpringVelocity,
                       options: .curveEaseOut,
                       animations: {
                        self.alpha = .one
        })
    }
    
    func startMainAnimations() {
        let imageViewRotationOffset = 30 * CGFloat.pi/180
        self.setstartingPositions(imageViewRotationOffset)
        self.startMainAnimations(imageViewRotationOffset)
    }
    
    private func setstartingPositions(_ imageViewRotationOffset: CGFloat) {
        let imageTranslation: CGFloat = 400
        let buttonTranslation: CGFloat = 500
        
        self.currentUserImageView.transform = CGAffineTransform(rotationAngle: imageViewRotationOffset)
            .concatenating(CGAffineTransform(translationX: imageTranslation, y: .zero))
        
        self.matchedCardImageView.transform = CGAffineTransform(rotationAngle: -imageViewRotationOffset)
            .concatenating(CGAffineTransform(translationX: -imageTranslation, y: .zero))
        
        self.keepSwipingButton.transform = CGAffineTransform(translationX: buttonTranslation, y: .zero)
    }
    
    private func startMainAnimations(_ imageViewRotationOffset: CGFloat) {
        let overallDuration: Double = 1.2
        let singleAnimationDuration: Double = 0.5
        let secondaryAnimationsStartTime: Double = 0.7
        
        UIView.animateKeyframes(withDuration: overallDuration, delay: .zero, options: .calculationModeCubic, animations: {
            
            UIView.addKeyframe(withRelativeStartTime: .zero, relativeDuration: singleAnimationDuration, animations: {
                self.currentUserImageView.transform = CGAffineTransform(rotationAngle: imageViewRotationOffset)
                self.matchedCardImageView.transform = CGAffineTransform(rotationAngle: -imageViewRotationOffset)
            })
            
            UIView.addKeyframe(withRelativeStartTime: secondaryAnimationsStartTime, relativeDuration: singleAnimationDuration, animations: {
                self.currentUserImageView.transform = .identity
                self.matchedCardImageView.transform = .identity
            })
            
            UIView.addKeyframe(withRelativeStartTime: secondaryAnimationsStartTime, relativeDuration: singleAnimationDuration, animations: {
                self.keepSwipingButton.transform = .identity
            })
        })
    }
    
    @objc
    private func handleDismiss() {
        self.delegate?.matchViewDidDismissMatchView(matchView: self)
        self.animateFadeOut()
    }
    
    private func animateFadeOut() {
        UIView.animate(withDuration: self.fadeDuration,
                       delay: self.fadeDelay,
                       usingSpringWithDamping: self.fadeSpringDamping,
                       initialSpringVelocity: self.fadeSpringVelocity,
                       options: .curveEaseOut,
                       animations: {
            self.alpha = .zero
        }) { _ in
            self.removeFromSuperview()
        }
    }
}
