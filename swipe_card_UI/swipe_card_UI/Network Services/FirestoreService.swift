//
//  FirestoreService.swift
//  swipe_card_UI
//
//  Created by Jack Smith on 23/05/2020.
//  Copyright © 2020 jack-adam-smith. All rights reserved.
//

import FirebaseFirestore

final class FirestoreService {
    
    // MARK: - Properties
    
    static let shared = FirestoreService()
    
    private let firestoreRefrence = Firestore.firestore()
    
    private let carsCollectionPath = "cars"
    private let homesCollectionPath = "homes"
    private let peopleCollectionPath = "people"
    private let petsCollectionPath = "pets"
    
    // MARK: - Init
    
    private func Init() {}
    
    // MARK: - Methods
    
    func fetchPosts(completion: @escaping (_ posts: [Post]?) -> Void) {
        
        var posts = [Post]()
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        self.fetchCars { items in
            self.handleFetchResponse(posts: &posts, items: items, dispatchGroup: dispatchGroup)
        }
        
        dispatchGroup.enter()
        self.fetchPets { items in
            self.handleFetchResponse(posts: &posts, items: items, dispatchGroup: dispatchGroup)
        }
        
        dispatchGroup.enter()
        self.fetchHomes { items in
            self.handleFetchResponse(posts: &posts, items: items, dispatchGroup: dispatchGroup)
        }
        
        dispatchGroup.enter()
        self.fetchPeople { items in
            self.handleFetchResponse(posts: &posts, items: items, dispatchGroup: dispatchGroup)
        }
        
        dispatchGroup.notify(queue: .main) {
            posts.count == .zero ? completion(nil) : completion(posts)
        }
    }
    
    func fetchCars(completion: @escaping (_ cars: [Car]?) -> Void) {
        self.firestoreRefrence.collection(self.carsCollectionPath).getDocuments { snapshot, error in
            
            if error != nil {
                completion(nil)
                return
            }
            
            guard let snapshot = snapshot else {
                completion(nil)
                return
            }
            
            var cars = [Car]()
            snapshot.documents.forEach { document in
                let car = Car(firestoreData: document.data())
                cars.append(car)
            }
            completion(cars)
        }
    }
    
    func fetchHomes(completion: @escaping (_ homes: [Home]?) -> Void) {
        self.firestoreRefrence.collection(self.homesCollectionPath).getDocuments { snapshot, error in
            
            if error != nil {
                completion(nil)
                return
            }
            
            guard let snapshot = snapshot else {
                completion(nil)
                return
            }
            
            var homes = [Home]()
            snapshot.documents.forEach { document in
                let home = Home(firestoreData: document.data())
                homes.append(home)
            }
            completion(homes)
        }
    }
    
    func fetchPeople(completion: @escaping (_ people: [Person]?) -> Void) {
        self.firestoreRefrence.collection(self.peopleCollectionPath).getDocuments { snapshot, error in
            
            if error != nil {
                completion(nil)
                return
            }
            
            guard let snapshot = snapshot else {
                completion(nil)
                return
            }
            
            var people = [Person]()
            snapshot.documents.forEach { document in
                let person = Person(firestoreData: document.data())
                people.append(person)
            }
            completion(people)
        }
    }
    
    func fetchPets(completion: @escaping (_ pets: [Pet]?) -> Void) {
        self.firestoreRefrence.collection(self.petsCollectionPath).getDocuments { snapshot, error in
            
            if error != nil {
                completion(nil)
                return
            }
            
            guard let snapshot = snapshot else {
                completion(nil)
                return
            }
            
            var pets = [Pet]()
            snapshot.documents.forEach { document in
                let pet = Pet(firestoreData: document.data())
                pets.append(pet)
            }
            completion(pets)
        }
    }
    
    private func handleFetchResponse(posts: inout [Post],
                                     items: [Post]?,
                                     dispatchGroup: DispatchGroup) {
        
        guard let items = items else {
            dispatchGroup.leave()
            return
        }
        
        posts.append(contentsOf: items)
        dispatchGroup.leave()
    }
}
