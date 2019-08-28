//
//  Advert.swift
//  swipe_card_UI
//
//  Created by Jack Smith on 26/08/2019.
//  Copyright © 2019 jack-adam-smith. All rights reserved.
//

import UIKit

class Person : ProducesCardViewModel {
    
    // MARK: - Properties
    
    let backgroundColour = UIColor.colour5
    
    var name : String?
    var age : Int?
    var profession : String?
    var relationshipStatus : String?
    var hometown : String?
    var image : UIImage?
    
    // MARK: - Init
    
    init(dictionary: [String : Any]) {
        
        self.name = dictionary["name"] as? String
        self.age = dictionary["age"] as? Int
        self.profession = dictionary["profession"] as? String
        self.relationshipStatus = dictionary["relationshipStatus"] as? String
        self.hometown = dictionary["hometown"] as? String
        self.image = dictionary["image"] as? UIImage
        
    }
    
    // MARK: - Handlers
    
    func toCardViewModel() -> CardViewModel {
        
        let attributedText = NSMutableAttributedString(string: name ?? "", attributes: [.font : UIFont.boldSystemFont(ofSize: 24)])
        
        let ageString = NSAttributedString(string: "\n\(age ?? 18)" , attributes: [.font : UIFont.systemFont(ofSize: 24)])
        let professionString = NSAttributedString(string: "\n\(profession ?? "")" , attributes: [.font : UIFont.systemFont(ofSize: 20)])
        let relationshipStatusString = NSAttributedString(string: "\n\(relationshipStatus ?? "")" , attributes: [.font : UIFont.systemFont(ofSize: 20)])
        let hometownString = NSAttributedString(string: "\n\(hometown ?? "")" , attributes: [.font : UIFont.systemFont(ofSize: 20)])
        
        attributedText.append(ageString)
        attributedText.append(professionString)
        attributedText.append(relationshipStatusString)
        attributedText.append(hometownString)
        
        let cardViewModel = CardViewModel(image: image ?? UIImage(), backgroundColour: backgroundColour, attributedIntro: attributedText, textAlignment: .left)
        
        return cardViewModel
        
    }
    
}
