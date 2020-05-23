//
//  UIButton+ConvenienceInit.swift
//  swipe_card_UI
//
//  Created by Jack Smith on 23/05/2020.
//  Copyright © 2020 jack-adam-smith. All rights reserved.
//

import UIKit

extension UIButton {
    
    convenience init(image: UIImage, tintColour: UIColor) {
        self.init(type: .system)
        self.setImage(image, for: .normal)
        self.tintColor = tintColour
    }
}
