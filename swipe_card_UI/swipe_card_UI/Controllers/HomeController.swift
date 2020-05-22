//
//  HomeController.swift
//  swipe_card_UI
//
//  Created by Jack Smith on 26/08/2019.
//  Copyright © 2019 jack-adam-smith. All rights reserved.
//

import UIKit

// MARK: - Protocols

protocol CardDelegate {
    func didRemoveCard(card: Card)
    func handleLike()
    func handleDislike()
}

protocol MatchViewDelegate {
    func didDismissMatchView()
}

class HomeController: UIViewController {
    
    //MARK:- Properties
    
    let cardsDeckView = UIView()
    let navBar = NavBar()
    let navBarHeight: CGFloat = 60
    
    var previousCard: Card?
    var topCard: Card?
    var posts = [Post]()
    
    lazy var bottomControls : BottomControls = {
        let controls = BottomControls()
        controls.backButton.addTarget(self, action: #selector(handleRefresh), for: .touchUpInside)
        controls.dislikeButton.addTarget(self, action: #selector(handleDislike), for: .touchUpInside)
        controls.likeButton.addTarget(self, action: #selector(handleLike), for: .touchUpInside)
        controls.heightAnchor.constraint(equalToConstant: 110).isActive = true
        return controls
    }()
    
    lazy var mainStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [cardsDeckView, bottomControls])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 12, left: 12, bottom: 0, right: 12)
        return stackView
    }()
    
    fileprivate var CardViewModels = [CardViewModel]()
    
    // MARK:- Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupAllCards()
    }
    
}

// MARK: - Protocol Implementations

extension HomeController: CardDelegate, MatchViewDelegate {
    
    func didDismissMatchView() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func didRemoveCard(card: Card) {
        self.topCard?.removeFromSuperview()
        self.topCard = self.topCard?.nextCardView
    }
    
}

