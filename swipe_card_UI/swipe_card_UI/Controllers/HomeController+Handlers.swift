//
//  HomeController+Methods.swift
//  swipe_card_UI
//
//  Created by Jack Smith on 28/08/2019.
//  Copyright © 2019 jack-adam-smith. All rights reserved.
//

import UIKit

extension HomeController {
    
    func setupUI(){
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(mainStackView)
        view.addSubview(navBar)
        view.fillSuperview()
        
        let layoutGuide = view.safeAreaLayoutGuide
        navBar.topAnchor.constraint(equalTo: layoutGuide.topAnchor).isActive = true
        navBar.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor).isActive = true
        navBar.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor).isActive = true
        navBar.heightAnchor.constraint(equalToConstant: navBarHeight).isActive = true
        
        mainStackView.topAnchor.constraint(equalTo: navBar.bottomAnchor).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor).isActive = true
        mainStackView.bringSubviewToFront(cardsDeckView)
        
        addStatusBarCover(colour: .white)
    }
    
    func addStatusBarCover(colour: UIColor) {
        let statusBarCover = UIView()
        statusBarCover.backgroundColor = colour
        statusBarCover.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(statusBarCover)
        statusBarCover.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        statusBarCover.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        statusBarCover.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        statusBarCover.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    }
    
    fileprivate func performSwipeAnimation(translation: CGFloat, angle: CGFloat) {
        let duration = 0.5
        
        let translationAnimation = CABasicAnimation(keyPath: "position.x")
        translationAnimation.toValue = translation
        translationAnimation.duration = duration
        translationAnimation.fillMode = .forwards
        translationAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        translationAnimation.isRemovedOnCompletion = false
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = angle*CGFloat.pi/180
        rotationAnimation.duration = duration
        
        let card = topCard
        topCard = card?.nextCardView
        
        CATransaction.setCompletionBlock {
            card?.removeFromSuperview()
        }
        
        card?.layer.add(translationAnimation, forKey: "translation")
        card?.layer.add(rotationAnimation, forKey: "rotation")
        
        CATransaction.commit()
    }
    
    fileprivate func presentMatchView(withMatch: Card) {
        let matchView = MatchView()
        matchView.viewModel = MatchedViewModel(user: user, card: withMatch)
        matchView.delegate = self
        view.addSubview(matchView)
        navigationController?.setNavigationBarHidden(true, animated: false)
        matchView.fillSuperview()
    }
    
    func setupAllCards() {
        people.forEach { (person) in
            let card = setupCardFromPerson(person: person)
            linkCardInList(card: card)
        }
        
        cars.forEach { (car) in
            let card = setupCardFromCar(car: car)
            linkCardInList(card: card)
        }
        
        pets.forEach { (pet) in
            let card = setupCardFromPet(pet: pet)
            linkCardInList(card: card)
        }
        
        houses.forEach { (house) in
            let card = setupCardFromHouse(house: house)
            linkCardInList(card: card)
        }
    }
    
    fileprivate func linkCardInList(card: Card) {
        previousCard?.nextCardView = card
        previousCard = card
        if self.topCard == nil {
            self.topCard = card
        }
    }
    
    fileprivate func setupCardFromPerson(person: Person) -> Card {
        let card = Card()
        card.cardViewModel = person.toCardViewModel()
        card.delegate = self
        cardsDeckView.addSubview(card)
        cardsDeckView.sendSubviewToBack(card)
        card.fillSuperview()
        return card
    }
    
    fileprivate func setupCardFromCar(car: Car) -> Card {
        let card = Card()
        card.cardViewModel = car.toCardViewModel()
        card.delegate = self
        cardsDeckView.addSubview(card)
        cardsDeckView.sendSubviewToBack(card)
        card.fillSuperview()
        return card
    }
    
    fileprivate func setupCardFromPet(pet: Pet) -> Card {
        let card = Card()
        card.cardViewModel = pet.toCardViewModel()
        card.delegate = self
        cardsDeckView.addSubview(card)
        cardsDeckView.sendSubviewToBack(card)
        card.fillSuperview()
        return card
    }
    
    fileprivate func setupCardFromHouse(house: House) -> Card {
        let card = Card()
        card.cardViewModel = house.toCardViewModel()
        card.delegate = self
        cardsDeckView.addSubview(card)
        cardsDeckView.sendSubviewToBack(card)
        card.fillSuperview()
        return card
    }
    
    @objc func handleRefresh() {
        if topCard == nil {
            setupAllCards()
        }
    }
    
    @objc func handleDislike() {
        performSwipeAnimation(translation: -700, angle: -15)
    }
    
    @objc func handleLike() {
        let card = topCard
        performSwipeAnimation(translation: 700, angle: 15)
        self.presentMatchView(withMatch: card!)
    }
    
}
