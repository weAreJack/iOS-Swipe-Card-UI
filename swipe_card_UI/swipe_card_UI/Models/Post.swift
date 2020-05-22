//
//  Post.swift
//  swipe_card_UI
//
//  Created by Jack Smith on 22/05/2020.
//  Copyright © 2020 jack-adam-smith. All rights reserved.
//

import UIKit

class Post {
    
    // MARK: - Properties
    
    var backgroundColour: UIColor {
        return .white
    }
    
    var imageUrl: String
    private let FirestoreKey_image = "imageUrl"
    
    // MARK: - Init
    
    init(firestoreData: [String: Any]) {
        self.imageUrl = firestoreData[FirestoreKey_image] as! String
    }
}
