//
//  House.swift
//  swipe_card_UI
//
//  Created by Jack Smith on 26/08/2019.
//  Copyright © 2019 jack-adam-smith. All rights reserved.
//

import UIKit

class House : ProducesCardViewModel {
    
    // MARK: - Properties
    
    let backgroundColour = UIColor.colour4
    
    var addess : String?
    var type : String?
    var numberOfBedrooms : Int?
    var numberOfBathrooms : Int?
    var price : Int?
    var image : UIImage?
    
    // MARK: - Init
    
    init(dictionary: [String : Any]) {
        
        self.addess = dictionary["addess"] as? String
        self.type = dictionary["type"] as? String
        self.numberOfBedrooms = dictionary["numberOfBedrooms"] as? Int
        self.numberOfBathrooms = dictionary["numberOfBathrooms"] as? Int
        self.price = dictionary["price"] as? Int
        self.image = dictionary["image"] as? UIImage
        
    }
    
    // MARK: - Handlers
    
    func toCardViewModel() -> CardViewModel {
        
        let attributedText = NSMutableAttributedString(string: addess ?? "", attributes: [.font : UIFont.boldSystemFont(ofSize: 24)])
        
        let typeString = NSAttributedString(string: "\n\(type ?? "")" , attributes: [.font : UIFont.systemFont(ofSize: 24)])
        let numberOfBedroomsString = NSAttributedString(string: "\n\(numberOfBedrooms ?? 0) Bedrooms" , attributes: [.font : UIFont.systemFont(ofSize: 20)])
        let numberOfBathroomsString = NSAttributedString(string: "\n\(numberOfBathrooms ?? 0) Bathrooms" , attributes: [.font : UIFont.systemFont(ofSize: 20)])
        let priceString = NSAttributedString(string: "\n£\(price ?? 100000)" , attributes: [.font : UIFont.systemFont(ofSize: 20)])
        
        attributedText.append(typeString)
        attributedText.append(numberOfBedroomsString)
        attributedText.append(numberOfBathroomsString)
        attributedText.append(priceString)
        
        let cardViewModel = CardViewModel(image: image ?? UIImage(), backgroundColour: backgroundColour, attributedIntro: attributedText, textAlignment: .center)
        
        return cardViewModel
        
    }

}
