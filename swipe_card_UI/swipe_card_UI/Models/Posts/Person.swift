//
//  Advert.swift
//  swipe_card_UI
//
//  Created by Jack Smith on 26/08/2019.
//  Copyright © 2019 jack-adam-smith. All rights reserved.
//

import UIKit

class Person: Post, ProducesCardViewModel {
    
    // MARK: - Properties
    
    override var backgroundColour: UIColor {
        return UIColor.colour5
    }
    
    private var name: String = "Jack"
    private var age: Int = 26
    private var profession: String = "Developer"
    private var relationshipStatus: String = "Single"
    private var hometown: String = "Hull"
    
    private let FirestoreKey_name = "name"
    private let FirestoreKey_age = "age"
    private let FirestoreKey_profession = "profession"
    private let FirestoreKey_relationshipStatus = "relationshipStatus"
    private let FirestoreKey_hometown = "hometown"
    
    // MARK: - Init
    
    override init() {
        super.init()
    }
    
    override init(firestoreData: [String: Any]) {
        self.name = firestoreData[FirestoreKey_name] as! String
        self.age = firestoreData[FirestoreKey_age] as! Int
        self.profession = firestoreData[FirestoreKey_profession] as! String
        self.relationshipStatus = firestoreData[FirestoreKey_relationshipStatus] as! String
        self.hometown = firestoreData[FirestoreKey_hometown] as! String
        super.init(firestoreData: firestoreData)
    }
    
    // MARK: - Methods
    
    func toCardViewModel() -> CardViewModel {
        let attributedText = NSMutableAttributedString(string: self.name, attributes: [.font: UIFont.boldSystemFont(ofSize: 24)])
        
        let ageString = NSAttributedString(string: "\n\(self.age)" , attributes: [.font: UIFont.systemFont(ofSize: 24)])
        let professionString = NSAttributedString(string: "\n\(self.profession)" , attributes: [.font: UIFont.systemFont(ofSize: 20)])
        let relationshipStatusString = NSAttributedString(string: "\n\(self.relationshipStatus)" , attributes: [.font: UIFont.systemFont(ofSize: 20)])
        let hometownString = NSAttributedString(string: "\n\(self.hometown)" , attributes: [.font: UIFont.systemFont(ofSize: 20)])
        
        attributedText.append(ageString)
        attributedText.append(professionString)
        attributedText.append(relationshipStatusString)
        attributedText.append(hometownString)
        
        let cardViewModel = CardViewModel(imageUrl: self.imageUrl,
                                          backgroundColour: self.backgroundColour,
                                          attributedIntro: attributedText,
                                          textAlignment: .left)
        
        return cardViewModel
    }
    
}
