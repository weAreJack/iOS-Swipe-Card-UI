//
//  MatchedViewModel.swift
//  swipe_card_UI
//
//  Created by Jack Smith on 27/08/2019.
//  Copyright © 2019 jack-adam-smith. All rights reserved.
//

import UIKit

struct MatchedViewModel {
    
    // MARK: - Properties
    
    let currentUserImage : UIImage
    let currentUserBackgroundColour : UIColor
    let matchedCardImage : UIImage
    let matchedCardBackgroundColour : UIColor
    
    // MARK: - Init
    
    init(user: Person, card: Card) {
        currentUserImage = user.image ?? #imageLiteral(resourceName: "placeholder")
        currentUserBackgroundColour = .purple
        matchedCardImage = card.cardViewModel.image
        matchedCardBackgroundColour = card.cardViewModel.backgroundColour
    }
    
    
}
