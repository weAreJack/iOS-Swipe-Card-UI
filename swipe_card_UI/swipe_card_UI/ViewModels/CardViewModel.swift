//
//  CardViewModel.swift
//  swipe_card_UI
//
//  Created by Jack Smith on 26/08/2019.
//  Copyright © 2019 jack-adam-smith. All rights reserved.
//

import UIKit

protocol ProducesCardViewModel {

    var backgroundColour: UIColor { get }
    var cardViewModel: CardViewModel { get }
    
    func toCardViewModel() -> CardViewModel
}

extension ProducesCardViewModel {
    
    var cardViewModel: CardViewModel {
        return toCardViewModel()
    }
}

struct CardViewModel {
    let imageUrl: URL?
    let backgroundColour: UIColor
    let attributedIntro: NSAttributedString
    let textAlignment: NSTextAlignment
}
