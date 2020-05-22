//
//  User.swift
//  swipe_card_UI
//
//  Created by Jack Smith on 26/08/2019.
//  Copyright © 2019 jack-adam-smith. All rights reserved.
//

import UIKit

class Car: Post, ProducesCardViewModel {
    
    // MARK: - Properties
    
    override var backgroundColour: UIColor {
        return UIColor.colour1
    }
    
    private var make: String
    private var model: String
    private var year: Int
    private var mileage: Int
    private var price: Int
    
    private let FirestoreKey_make = "make"
    private let FirestoreKey_model = "model"
    private let FirestoreKey_year = "year"
    private let FirestoreKey_mileage = "mileage"
    private let FirestoreKey_price = "price"
    
    // MARK: - Init
    
    override init(firestoreData: [String: Any]) {
        self.make = firestoreData[FirestoreKey_make] as! String
        self.model = firestoreData[FirestoreKey_model] as! String
        self.year = firestoreData[FirestoreKey_year] as! Int
        self.mileage = firestoreData[FirestoreKey_mileage] as! Int
        self.price = firestoreData[FirestoreKey_price] as! Int
        super.init(firestoreData: firestoreData)
    }
    
    // MARK: - Methods
    
    func toCardViewModel() -> CardViewModel {
        let attributedText = NSMutableAttributedString(string: self.make, attributes: [.font: UIFont.boldSystemFont(ofSize: 24)])
        
        let modelString = NSAttributedString(string: "\n\(self.model)", attributes: [.font: UIFont.systemFont(ofSize: 24)])
        let ageString = NSAttributedString(string: "\n\(self.year)", attributes: [.font: UIFont.systemFont(ofSize: 20)])
        let mileageString = NSAttributedString(string: "\n\(self.mileage) miles", attributes: [.font: UIFont.systemFont(ofSize: 20)])
        let priceString = NSAttributedString(string: "\n£\(self.price)", attributes: [.font: UIFont.systemFont(ofSize: 20)])
        
        attributedText.append(modelString)
        attributedText.append(ageString)
        attributedText.append(mileageString)
        attributedText.append(priceString)
        
        let cardViewModel = CardViewModel(imageUrl: self.imageUrl,
                                          backgroundColour: self.backgroundColour,
                                          attributedIntro: attributedText,
                                          textAlignment: .right)
        
        return cardViewModel
    }
}
