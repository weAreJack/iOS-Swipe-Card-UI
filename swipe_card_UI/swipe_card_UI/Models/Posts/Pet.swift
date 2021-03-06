//
//  File.swift
//  swipe_card_UI
//
//  Created by Jack Smith on 26/08/2019.
//  Copyright © 2019 jack-adam-smith. All rights reserved.
//

import UIKit

class Pet: Post, ProducesCardViewModel {
    
    // MARK: - Properties
    
    override var backgroundColour: UIColor {
        return UIColor.colour3
    }
    
    private var animal: String
    private var name: String
    private var age: Int
    private var hometown: String
    
    private let FirestoreKey_animal = "animal"
    private let FirestoreKey_name = "name"
    private let FirestoreKey_age = "age"
    private let FirestoreKey_hometown = "hometown"
    
    // MARK: - Init
    
    override init(firestoreData: [String : Any]) {
        self.animal = firestoreData[FirestoreKey_animal] as! String
        self.name = firestoreData[FirestoreKey_name] as! String
        self.age = firestoreData[FirestoreKey_age] as! Int
        self.hometown = firestoreData[FirestoreKey_hometown] as! String
        super.init(firestoreData: firestoreData)
    }
    
    // MARK: - Methods
    
    func toCardViewModel() -> CardViewModel {
        let attributedText = NSMutableAttributedString(string: self.animal, attributes: [.font : UIFont.boldSystemFont(ofSize: 24)])
        
        let nameString = NSAttributedString(string: "\n\(self.name)", attributes: [.font : UIFont.systemFont(ofSize: 24)])
        let ageString = NSAttributedString(string: "\n\(self.age)", attributes: [.font : UIFont.systemFont(ofSize: 20)])
        let hometownString = NSAttributedString(string: "\n\(self.hometown)" , attributes: [.font : UIFont.systemFont(ofSize: 20)])
        
        attributedText.append(nameString)
        attributedText.append(ageString)
        attributedText.append(hometownString)
        
        let cardViewModel = CardViewModel(imageUrl: self.imageUrl,
                                          backgroundColour: self.backgroundColour,
                                          attributedIntro: attributedText,
                                          textAlignment: .left)
        
        return cardViewModel
    }
}
