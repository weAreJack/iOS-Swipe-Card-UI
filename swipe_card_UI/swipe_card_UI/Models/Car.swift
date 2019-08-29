//
//  User.swift
//  swipe_card_UI
//
//  Created by Jack Smith on 26/08/2019.
//  Copyright © 2019 jack-adam-smith. All rights reserved.
//

import UIKit

class Car : ProducesCardViewModel {
    
    // MARK: - Properties
    
    let backgroundColour = UIColor.colour1
    
    var make : String?
    var model : String?
    var year : Int?
    var mileage : Int?
    var price : Int?
    var image : UIImage?
    
    // MARK: - Init
    
    init(dictionary: [String : Any]) {
        self.make = dictionary["make"] as? String
        self.model = dictionary["model"] as? String
        self.year = dictionary["age"] as? Int
        self.mileage = dictionary["mileage"] as? Int
        self.price = dictionary["price"] as? Int
        self.image = dictionary["image"] as? UIImage
    }
    
    // MARK: - Handlers
    
    func toCardViewModel() -> CardViewModel {
        let attributedText = NSMutableAttributedString(string: make ?? "", attributes: [.font : UIFont.boldSystemFont(ofSize: 24)])
        
        let modelString = NSAttributedString(string: "\n\(model ?? "")" , attributes: [.font : UIFont.systemFont(ofSize: 24)])
        let ageString = NSAttributedString(string: "\n\(year ?? 2019)" , attributes: [.font : UIFont.systemFont(ofSize: 20)])
        let mileageString = NSAttributedString(string: "\n\(mileage ?? 0) miles" , attributes: [.font : UIFont.systemFont(ofSize: 20)])
        let priceString = NSAttributedString(string: "\n£\(price ?? 10000)" , attributes: [.font : UIFont.systemFont(ofSize: 20)])
        
        attributedText.append(modelString)
        attributedText.append(ageString)
        attributedText.append(mileageString)
        attributedText.append(priceString)
        
        let cardViewModel = CardViewModel(image: image ?? UIImage(), backgroundColour: backgroundColour, attributedIntro: attributedText, textAlignment: .right)
        
        return cardViewModel
    }
    
}
