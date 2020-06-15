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
    
    let currentUserImageUrl: URL?
    let currentUserBackgroundColour: UIColor
    let matchedCardImageUrl: URL?
    let matchedCardBackgroundColour: UIColor
    
    // MARK: - Init
    
    init(user: Person, post: CardViewModel) {
        self.currentUserImageUrl = user.imageUrl
        self.currentUserBackgroundColour = .purple
        self.matchedCardImageUrl = post.imageUrl
        self.matchedCardBackgroundColour = post.backgroundColour
    }
}
