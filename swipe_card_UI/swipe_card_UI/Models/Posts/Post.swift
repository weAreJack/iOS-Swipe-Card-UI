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
    
    var imageUrl: URL? = URL(string: "https://firebasestorage.googleapis.com/v0/b/swipe-b1dda.appspot.com/o/person.png?alt=media&token=dba0a24e-39fc-4138-a4cd-4f2b1d32f5b3")
    
    private let FirestoreKey_image = "imageUrl"
    
    // MARK: - Init
    
    init() {}
    
    init(firestoreData: [String: Any]) {
        let urlString = firestoreData[FirestoreKey_image] as! String
        self.imageUrl = URL(string: urlString)
    }
}
