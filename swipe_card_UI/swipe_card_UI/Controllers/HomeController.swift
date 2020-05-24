//
//  HomeController.swift
//  swipe_card_UI
//
//  Created by Jack Smith on 26/08/2019.
//  Copyright © 2019 jack-adam-smith. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    
    //MARK:- Properties
    
    private var posts = [ProducesCardViewModel]()
    private let bottomControls = BottomControls()
    private let cardsDeckView = UIView()
    private let navBar = NavBar()
    
    private var previousCard: Card?
    private var topCard: Card?
    private var activityView: UIActivityIndicatorView?
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.cardsDeckView, self.bottomControls])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 12, left: 12, bottom: .zero, right: 12)
        return stackView
    }()
    
    private let user = Person()
    
    private let navBarHeight: CGFloat = 60
    private let swipeTranslation: CGFloat = 700
    private let swipeAngle: CGFloat = 15
    
    // MARK:- Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureViews()
        self.layoutViews()
        self.setupAllCards()
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
        
        let card = topCard
        topCard = card?.nextCard
        
        CATransaction.setCompletionBlock {
            card?.removeFromSuperview()
        }
        
        card?.layer.add(translationAnimation, forKey: "translation")
        card?.layer.add(rotationAnimation, forKey: "rotation")
        
        CATransaction.commit()
    }
    
    private func presentMatchView(withMatch: Card) {
        let matchView = MatchView(viewModel: MatchedViewModel(user: self.user, card: withMatch))
        matchView.delegate = self
        
        self.view.addSubview(matchView)
        matchView.constraintsEqual(toView: self.view)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func setupAllCards() {
        self.showActivityView()
        FirestoreService.shared.fetchPosts { [weak self] posts in
            guard let self = self else {return}
            
            self.hideActivityView()
            guard var posts = posts else {
                self.showErrorAlert()
                return
            }
            
            posts.shuffle()
            posts.forEach { post in
                let card = self.setupCard(post: post as! ProducesCardViewModel)
                self.linkCardInList(card: card)
            }
        }
    }
    
    private func showActivityView() {
        let animationDuration: Double = 0.15
        
        self.activityView = UIActivityIndicatorView(style: .whiteLarge)
        self.activityView?.color = .black
        self.activityView?.alpha = .zero
        
        self.cardsDeckView.addSubview(self.activityView!)
        self.activityView?.centeringConstraints(centerXAnchor: self.cardsDeckView.centerXAnchor,
                                                centerYAnchor: self.cardsDeckView.centerYAnchor)
        
        self.activityView?.startAnimating()
        UIView.animate(withDuration: animationDuration) {
            self.activityView?.alpha = .one
        }
    }
    
    private func hideActivityView() {
        let animationDuration: Double = 0.15
        
        UIView.animate(withDuration: animationDuration, animations: {
            self.activityView?.alpha = .zero
        }) { _ in
            self.activityView?.stopAnimating()
            self.activityView?.removeFromSuperview()
            self.activityView = nil
        }
    }
    
    private func showErrorAlert() {
        let alertView = UIAlertController(title: "Ooops, something went wrong.",
                                          message: "We could not load any posts. Please check your internet connection and try again.",
                                          preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Okay", style: .cancel) { _ in
            alertView.dismiss(animated: true)
        }
        alertView.addAction(okayAction)
        self.present(alertView, animated: true)
    }
    
    private func linkCardInList(card: Card) {
        self.previousCard?.nextCard = card
        self.previousCard = card
        if self.topCard == nil {
            self.topCard = card
        }
    }
    
    private func setupCard(post: ProducesCardViewModel) -> Card {
        let card = Card(viewModel: post.toCardViewModel())
        card.delegate = self
        
        self.cardsDeckView.addSubview(card)
        self.cardsDeckView.sendSubviewToBack(card)
        card.constraintsEqual(toView: self.cardsDeckView)
        
        return card
    }
    
    private func handleRefresh() {
        if self.topCard == nil {
            self.setupAllCards()
        }
    }
    
    private func handleDislike() {
        self.performSwipeAnimation(translation: -self.swipeTranslation, angle: -self.swipeAngle)
    }
    
    private func handleLike() {
        guard let card = topCard else {
            return
        }
        
        self.performSwipeAnimation(translation: self.swipeTranslation, angle: self.swipeAngle)
        self.presentMatchView(withMatch: card)
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
