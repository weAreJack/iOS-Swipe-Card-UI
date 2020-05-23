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
    
    var previousCard: Card?
    var topCard: Card?
    var posts = [ProducesCardViewModel]()
    
    let bottomControls = BottomControls()
    let cardsDeckView = UIView()
    let navBar = NavBar()
    let navBarHeight: CGFloat = 60
    
    let user = Person()
    
    lazy var mainStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.cardsDeckView, self.bottomControls])
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
        self.configureViews()
        self.setupUI()
        self.setupAllCards()
    }
}
