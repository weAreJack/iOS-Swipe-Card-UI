//
//  File.swift
//  swipe_card_UI
//
//  Created by Jack Smith on 26/08/2019.
//  Copyright © 2019 jack-adam-smith. All rights reserved.
//

import UIKit

class Pet : ProducesCardViewModel {
    
    // MARK: - Properties
    
    let backgroundColour = UIColor.colour3
    
    var animal : String?
    var name : String?
    var age : Int?
    var hometown : String?
    var image : UIImage?
    
    // MARK: - Init
    
    init(dictionary: [String : Any]) {
        self.animal = dictionary["animal"] as? String
        self.name = dictionary["name"] as? String
        self.age = dictionary["age"] as? Int
        self.hometown = dictionary["hometown"] as? String
        self.image = dictionary["image"] as? UIImage
    }
    
    // MARK: - Handlers
    
    func toCardViewModel() -> CardViewModel {
        let attributedText = NSMutableAttributedString(string: animal ?? "", attributes: [.font : UIFont.boldSystemFont(ofSize: 24)])
        
        let nameString = NSAttributedString(string: "\n\(name ?? "")" , attributes: [.font : UIFont.systemFont(ofSize: 24)])
        let ageString = NSAttributedString(string: "\n\(age ?? 0)" , attributes: [.font : UIFont.systemFont(ofSize: 20)])
        let hometownString = NSAttributedString(string: "\n\(hometown ?? "")" , attributes: [.font : UIFont.systemFont(ofSize: 20)])
        
        attributedText.append(nameString)
        attributedText.append(ageString)
        attributedText.append(hometownString)
        
        let cardViewModel = CardViewModel(image: image ?? UIImage(), backgroundColour: backgroundColour, attributedIntro: attributedText, textAlignment: .left)
        
        return cardViewModel
        
    }
    
}
