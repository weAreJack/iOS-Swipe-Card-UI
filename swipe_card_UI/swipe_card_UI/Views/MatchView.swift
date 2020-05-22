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
//            currentUserImageView.image = viewModel?.currentUserImage
            currentUserImageView.backgroundColor = viewModel?.currentUserBackgroundColour
//            matchedCardImageView.image = viewModel?.matchedCardImage
            matchedCardImageView.backgroundColor = viewModel?.matchedCardBackgroundColour
        }
    }

    let descriptionLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .center
        label.text = "You have a new match, view their profile to chat and purchase, or tap the keep swiping button to continue!"
        return label
    }()
    
    let itsAMatchImageView = UIImageView(image: #imageLiteral(resourceName: "its_a_match_view"))
    let keepSwipingButton = KeepSwipingButton(type: .system)
    let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    let currentUserImageView = RoundedImageView(frame: CGRect())
    let matchedCardImageView = RoundedImageView(frame: CGRect())

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

}

