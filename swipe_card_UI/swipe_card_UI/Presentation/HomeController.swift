//
//  HomeController.swift
//  swipe_card_UI
//
//  Created by Jack Smith on 26/08/2019.
//  Copyright © 2019 jack-adam-smith. All rights reserved.
//

import UIKit

class HomeController: BaseController {
    
    //MARK:- Properties
    
    private let bottomControls = BottomControls()
    private let cardsDeckView = UIView()
    private let navBar = NavBar()
    private var previousCard: Card?
    private var topCard: Card?
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.cardsDeckView, self.bottomControls])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 12, left: 12, bottom: .zero, right: 12)
        return stackView
    }()
    
    private var posts = [CardViewModel]()
    private var presenter: HomePresenterProtocol?
    
    private let navBarHeight: CGFloat = 60
    private let swipeTranslation: CGFloat = 700
    private let swipeAngle: CGFloat = 15
    
    // MARK:- Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = HomePresenter(self)
        
        self.configureViews()
        self.layoutViews()
        self.presenter?.fetchPosts()
    }
    
    // MARK: - Methods

    func configureViews() {
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        self.bottomControls.delegate = self
    }
    
    private func layoutViews(){
        self.view.addSubview(self.mainStackView)
        self.view.addSubview(self.navBar)
        
        let layoutGuide = view.safeAreaLayoutGuide
        self.navBar.borderConstraints(topAnchor: layoutGuide.topAnchor,
                                      leadingAnchor: layoutGuide.leadingAnchor,
                                      bottomAnchor: nil,
                                      trailingAnchor: layoutGuide.trailingAnchor,
                                      size: .init(width: CGFloat.zero, height: self.navBarHeight))
        
        self.mainStackView.borderConstraints(topAnchor: self.navBar.bottomAnchor,
                                             leadingAnchor: self.view.leadingAnchor,
                                             bottomAnchor: layoutGuide.bottomAnchor,
                                             trailingAnchor: self.view.trailingAnchor)
        
        self.mainStackView.bringSubviewToFront(self.cardsDeckView)
        self.addStatusBarCover(colour: UIColor.white)
    }
    
    private func performSwipeAnimation(translation: CGFloat, angle: CGFloat) {
        let duration = 0.5
        
        let translationAnimation = CABasicAnimation(keyPath: "position.x")
        translationAnimation.toValue = translation
        translationAnimation.duration = duration
        translationAnimation.fillMode = .forwards
        translationAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        translationAnimation.isRemovedOnCompletion = false
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = angle * CGFloat.pi / 180
        rotationAnimation.duration = duration
        
        let card = self.topCard
        self.topCard = card?.nextCard
        
        CATransaction.setCompletionBlock {
            card?.removeFromSuperview()
        }
        
        card?.layer.add(translationAnimation, forKey: "translation")
        card?.layer.add(rotationAnimation, forKey: "rotation")
        
        CATransaction.commit()
    }
    
    private func presentMatchView(viewModel: MatchedViewModel) {
        let matchView = MatchView(viewModel: viewModel)
        matchView.delegate = self
        
        self.view.addSubview(matchView)
        matchView.constraintsEqual(toView: self.view)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func handleRefresh() {
        self.cardsDeckView.subviews.forEach { $0.removeFromSuperview() }
        self.topCard = nil
        self.presenter?.fetchPosts()
    }
    
    private func handleDislike() {
        self.performSwipeAnimation(translation: -self.swipeTranslation, angle: -self.swipeAngle)
    }
    
    private func handleLike() {
        guard let post = self.topCard?.viewModel else {
            return
        }
        
        self.performSwipeAnimation(translation: self.swipeTranslation, angle: self.swipeAngle)
        self.presenter?.checkForMatch(post: post)
    }
}

extension HomeController: BottomControlsDelegate {
    
    func bottomControlsDidTapBackButton(bottomControls: BottomControls) {
        self.handleRefresh()
    }
    
    func bottomControlsDidTapDislikeButton(bottomControls: BottomControls) {
        self.handleDislike()
    }
    
    func bottomControlsDidTapLikeButton(bottomControls: BottomControls) {
        self.handleLike()
    }
}

extension HomeController: CardDelegate, MatchViewDelegate {
    
    func cardDidSwipeRight(card: Card) {
        self.handleLike()
    }
    
    func cardDidSwipeLeft(card: Card) {
        self.handleDislike()
    }
    
    func matchViewDidDismissMatchView(matchView: MatchView) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

extension HomeController: HomePresenterDelegate {
    
    func homePresenterDidFindMatch(_ homePresenter: HomePresenter, matchedViewModel: MatchedViewModel) {
        self.presentMatchView(viewModel: matchedViewModel)
    }
    
    func homePresenterDidBeginPostFetch(_ homePresenter: HomePresenter) {
        self.showActivityView()
    }
    
    func homePresenterDidFetchPost(_ homePresenter: HomePresenter, post: CardViewModel) {
        self.hideActivityView()
        
        let card = Card(viewModel: post)
        card.delegate = self
        self.cardsDeckView.addSubview(card)
        self.cardsDeckView.sendSubviewToBack(card)
        card.constraintsEqual(toView: self.cardsDeckView)
        
        self.linkCardInList(card: card)
    }
    
    private func linkCardInList(card: Card) {
        self.previousCard?.nextCard = card
        self.previousCard = card
        if self.topCard == nil {
            self.topCard = card
        }
    }
}
