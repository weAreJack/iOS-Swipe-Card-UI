//
//  CardViewModel.swift
//  swipe_card_UI
//
//  Created by Jack Smith on 26/08/2019.
//  Copyright © 2019 jack-adam-smith. All rights reserved.
//

import UIKit

protocol ProducesCardViewModel {
    func toCardViewModel() -> CardViewModel
}

struct CardViewModel {
    let image : UIImage
    let backgroundColour : UIColor
    let attributedIntro : NSAttributedString
    let textAlignment : NSTextAlignment
}

