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
                                   "image" : #imageLiteral(resourceName: "person")])
    
    var previousCard : Card?
    var topCard : Card?
    var people = [Person(dictionary: ["name" : "Hannah",
                                      "age" : 23,
                                      "profession" : "Lawyer",
                                      "relationshipStatus" : "Single",
                                      "hometown" : "Leeds",
                                      "image" : #imageLiteral(resourceName: "person")]),
                  Person(dictionary: ["name" : "John",
                                      "age" : 23,
                                      "profession" : "Designer",
                                      "relationshipStatus" : "Married",
                                      "hometown" : "London",
                                      "image" : #imageLiteral(resourceName: "person")])]
    
    var cars = [Car(dictionary: ["make" : "Ford",
                                 "model" : "Model E",
                                 "year" : 2015,
                                 "mileage" : 20000,
                                 "price" : 12450,
                                 "image" : #imageLiteral(resourceName: "car")]),
                Car(dictionary: ["make" : "BMW",
                                 "model" : "5 Series",
                                 "year" : 2018,
                                 "mileage" : 5000,
                                 "price" : 22750,
                                 "image" : #imageLiteral(resourceName: "car")])]
    
    var pets = [Pet(dictionary: ["animal" : "Dog",
                                 "name" : "Skip",
                                 "age" : 6,
                                 "hometown" : "Manchester",
                                 "image" : #imageLiteral(resourceName: "dog")]),
                Pet(dictionary: ["animal" : "Cat",
                                 "name" : "Terrance",
                                 "age" : 4,
                                 "hometown" : "York",
                                 "image" : #imageLiteral(resourceName: "cat")])]
    
    var houses = [House(dictionary: ["address" : "10 Blue Roqd",
                                     "type" : "Semi-Detached",
                                     "numberOfBedrooms" : 3,
                                     "numberOfBathrooms" : 2,
                                     "price" : 125000,
                                     "image" : #imageLiteral(resourceName: "house")]),
                  House(dictionary: ["address" : "20 Red Road",
                                     "type" : "Detached",
                                     "numberOfBedrooms" : 5,
                                     "numberOfBathrooms" : 3,
                                     "price" : 355000,
                                     "image" : #imageLiteral(resourceName: "house")])]
    
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

