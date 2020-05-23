//
//  House.swift
//  swipe_card_UI
//
//  Created by Jack Smith on 26/08/2019.
//  Copyright © 2019 jack-adam-smith. All rights reserved.
//

import UIKit

class Home: Post, ProducesCardViewModel {
    
    // MARK: - Properties
    
    override var backgroundColour: UIColor {
        return UIColor.colour4
    }
    
    private var type: String
    private var numberOfBedrooms: Int
    private var numberOfBathrooms: Int
    private var price: Int
    
    private let FirestoreKey_addess = "addess"
    private let FirestoreKey_type = "type"
    private let FirestoreKey_numberOfBedrooms = "numberOfBedrooms"
    private let FirestoreKey_numberOfBathrooms = "numberOfBathrooms"
    private let FirestoreKey_price = "price"
    
    // MARK: - Init
    
    override init(firestoreData: [String: Any]) {
        self.type = firestoreData[FirestoreKey_type] as! String
        self.numberOfBedrooms = firestoreData[FirestoreKey_numberOfBedrooms] as! Int
        self.numberOfBathrooms = firestoreData[FirestoreKey_numberOfBathrooms] as! Int
        self.price = firestoreData[FirestoreKey_price] as! Int
        super.init(firestoreData: firestoreData)
    }
    
    // MARK: - Methods
    
    func toCardViewModel() -> CardViewModel {
        let attributedText = NSMutableAttributedString(string: self.type, attributes: [.font : UIFont.boldSystemFont(ofSize: 24)])
        
        let numberOfBedroomsString = NSAttributedString(string: "\n\(self.numberOfBedrooms) Bedrooms", attributes: [.font : UIFont.systemFont(ofSize: 20)])
        let numberOfBathroomsString = NSAttributedString(string: "\n\(self.numberOfBathrooms) Bathrooms", attributes: [.font : UIFont.systemFont(ofSize: 20)])
        let priceString = NSAttributedString(string: "\n£\(self.price)", attributes: [.font : UIFont.systemFont(ofSize: 20)])
        
        attributedText.append(numberOfBedroomsString)
        attributedText.append(numberOfBathroomsString)
        attributedText.append(priceString)
        
        let cardViewModel = CardViewModel(imageUrl: self.imageUrl,
                                          backgroundColour: self.backgroundColour,
                                          attributedIntro: attributedText,
                                          textAlignment: .center)
        
        return cardViewModel
    }

}
