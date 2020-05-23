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

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        label.textColor = .white
        label.textAlignment = .center
        label.text = "You have a new match, view their profile to chat and purchase, or tap the keep swiping button to continue!"
        return label
    }()
    
    let itsAMatchImageView = UIImageView(image: #imageLiteral(resourceName: "its_a_match_view"))
    let keepSwipingButton = KeepSwipingButton(type: .system)
    let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    let currentUserImageView = CircularImageView(frame: CGRect())
    let matchedCardImageView = CircularImageView(frame: CGRect())

    lazy var views = [
        self.itsAMatchImageView,
        self.descriptionLabel,
        self.currentUserImageView,
        self.matchedCardImageView,
        self.keepSwipingButton
    ]
    
    var viewModel: MatchedViewModel
    weak var delegate: MatchViewDelegate?
    
    private let fadeDuration: Double = 1
    private let fadeDelay: Double = 0.2
    private let fadeSpringDamping: CGFloat = 1
    private let fadeSpringVelocity: CGFloat = 1
    
    // MARK: - Init
    
    init(viewModel: MatchedViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        self.layoutViews()
        self.configureViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViews() {
        self.currentUserImageView.sd_setImage(with: URL(string: self.viewModel.currentUserImageUrl), completed: nil)
        self.currentUserImageView.backgroundColor = viewModel.currentUserBackgroundColour
        
        self.matchedCardImageView.sd_setImage(with: URL(string: self.viewModel.matchedCardImageUrl), completed: nil)
        self.matchedCardImageView.backgroundColor = viewModel.matchedCardBackgroundColour
        
        self.keepSwipingButton.addTarget(self, action: #selector(self.handleDismiss), for: .touchUpInside)
        
        self.setupBlurView()
        self.startAnimations()
    }
    
    func layoutViews() {
        let imageWidth: CGFloat = 140
        
        self.views.forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(view)
            view.alpha = .zero
        }
        
        self.itsAMatchImageView.constraints(centerXAnchor: self.centerXAnchor,
                                            bottomAnchor: self.descriptionLabel.topAnchor,
                                            borderPadding: .init(top: .zero, left: .zero, bottom: 16, right: .zero),
                                            size: .init(width: 300, height: 80))
        
        self.descriptionLabel.borderConstraints(leadingAnchor: self.leadingAnchor,
                                                bottomAnchor: self.currentUserImageView.topAnchor,
                                                trailingAnchor: self.trailingAnchor,
                                                equalBorderPadding: 32,
                                                size: .init(width: .zero, height: 75))
        
        self.currentUserImageView.constraints(centerYAnchor: self.centerYAnchor,
                                              trailingAnchor: self.centerXAnchor,
                                              positionConstants: .init(x: .zero, y: 48),
                                              borderPadding: .init(top: .zero, left: .zero, bottom: .zero, right: 16),
                                              size: .init(width: imageWidth, height: imageWidth))
        
        self.matchedCardImageView.constraints(centerYAnchor: self.centerYAnchor,
                                              leadingAnchor: self.centerXAnchor,
                                              positionConstants: .init(x: .zero, y: 48),
                                              borderPadding: .init(top: .zero, left: 16, bottom: .zero, right: .zero),
                                              size: .init(width: imageWidth, height: imageWidth))
        
        self.keepSwipingButton.constraints(centerXAnchor: self.centerXAnchor,
                                           topAnchor: self.matchedCardImageView.bottomAnchor,
                                           borderPadding: .init(top: 32, left: .zero, bottom: .zero, right: .zero),
                                           size: .init(width: 300, height: 60))
    }
    
    private func setupBlurView() {
        self.alpha = .zero
        self.visualEffectView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleDismiss)))
        
        self.addSubview(visualEffectView)
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
            self.alpha = 1
        })
    }
    
    func startAnimations() {
        let imageViewRotationOffset = 30 * CGFloat.pi/180
        
        self.views.forEach {
            $0.alpha = 1
        }
        
        self.setstartingPositions(imageViewRotationOffset)
        self.startMainAnimations(imageViewRotationOffset)
    }
    
    private func setstartingPositions(_ imageViewRotationOffset: CGFloat) {
        self.currentUserImageView.transform = CGAffineTransform(rotationAngle: imageViewRotationOffset).concatenating(CGAffineTransform(translationX: 400, y: .zero))
        self.matchedCardImageView.transform = CGAffineTransform(rotationAngle: -imageViewRotationOffset).concatenating(CGAffineTransform(translationX: -400, y: .zero))
        self.keepSwipingButton.transform = CGAffineTransform(translationX: 500, y: .zero)
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
        }) { (_) in
            self.removeFromSuperview()
        }
    }
}
