//
//  MatchedViewModel.swift
//  swipe_card_UI
//
//  Created by Jack Smith on 27/08/2019.
//  Copyright © 2019 jack-adam-smith. All rights reserved.
//

import UIKit

class MatchedViewModel {
    
    // MARK: - Properties
    
    let currentUserImageUrl: String
    let currentUserBackgroundColour: UIColor
    let matchedCardImageUrl: String
    let matchedCardBackgroundColour: UIColor
    
    // MARK: - Init
    
    init(user: Person, card: Card) {
        self.currentUserImageUrl = user.imageUrl
        self.currentUserBackgroundColour = .purple
        self.matchedCardImageUrl = card.viewModel.imageUrl
        self.matchedCardBackgroundColour = card.viewModel.backgroundColour
    }
}
