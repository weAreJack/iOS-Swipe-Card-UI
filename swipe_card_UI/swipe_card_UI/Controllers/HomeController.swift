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
    let navBarHeight : CGFloat = 60
    let user = Person(dictionary: ["name" : "Jack",
                                   "age" : 25,
                                   "profession" : "Developer",
                                   "relationshipStatus" : "Single",
                                   "hometown" : "Sheffield",
                                   "image" : #imageLiteral(resourceName: "2")])
    
    var previousCard : Card?
    var topCard : Card?
    var people = [Person(dictionary: ["name" : "Hannah",
                                      "age" : 23,
                                      "profession" : "Lawyer",
                                      "relationshipStatus" : "Single",
                                      "hometown" : "Leeds",
                                      "image" : #imageLiteral(resourceName: "2")]),
                  Person(dictionary: ["name" : "John",
                                      "age" : 23,
                                      "profession" : "Designer",
                                      "relationshipStatus" : "Married",
                                      "hometown" : "London",
                                      "image" : #imageLiteral(resourceName: "3")])]
    
    var cars = [Car(dictionary: ["make" : "Ford",
                                 "model" : "Model E",
                                 "year" : 2015,
                                 "mileage" : 20000,
                                 "price" : 12450,
                                 "image" : #imageLiteral(resourceName: "2")]),
                Car(dictionary: ["make" : "BMW",
                                 "model" : "5 Series",
                                 "year" : 2018,
                                 "mileage" : 5000,
                                 "price" : 22750,
                                 "image" : #imageLiteral(resourceName: "2")])]
    
    var pets = [Pet(dictionary: ["animal" : "Dog",
                                 "name" : "Skip",
                                 "age" : 6,
                                 "hometown" : "Manchester",
                                 "image" : #imageLiteral(resourceName: "1")]),
                Pet(dictionary: ["animal" : "Cat",
                                 "name" : "Terrance",
                                 "age" : 4,
                                 "hometown" : "York",
                                 "image" : #imageLiteral(resourceName: "1")])]
    
    var houses = [House(dictionary: ["address" : "10 Blue Roqd",
                                     "type" : "Semi-Detached",
                                     "numberOfBedrooms" : 3,
                                     "numberOfBathrooms" : 2,
                                     "price" : 125000,
                                     "image" : #imageLiteral(resourceName: "3")]),
                  House(dictionary: ["address" : "20 Red Road",
                                     "type" : "Detached",
                                     "numberOfBedrooms" : 5,
                                     "numberOfBathrooms" : 3,
                                     "price" : 355000,
                                     "image" : #imageLiteral(resourceName: "3")])]
    
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
    
    // MARK: - Handlers
    
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
    
    fileprivate func performSwipeAnimation(translation: CGFloat, angle: CGFloat) {
        let duration = 0.4
        
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
    
    fileprivate func setupAllCards() {
        
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

