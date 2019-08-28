//
//  UIColorExtension.swift
//  swipe_card_UI
//
//  Created by Jack Smith on 26/08/2019.
//  Copyright © 2019 jack-adam-smith. All rights reserved.
//

import UIKit

extension UIColor {
    
    static let colour1 = UIColor(r: 80, g: 71, b: 70)
    static let colour2 = UIColor(r: 252, g: 247, b: 248)
    static let colour3 = UIColor(r: 206, g: 211, b: 220)
    static let colour4 = UIColor(r: 171, g: 168, b: 195)
    static let colour5 = UIColor(r: 39, g: 93, b: 173)
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
}

