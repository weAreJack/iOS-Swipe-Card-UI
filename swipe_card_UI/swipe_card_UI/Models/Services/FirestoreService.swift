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
    private let petsCollectionPath = "pest"
    
    // MARK: - Init
    
    private func Init() {}
    
    // MARK: - Methods
    
    func fetchPosts(completion: @escaping (_ posts: [Post]?) -> Void) {
        
        var posts = [Post]()
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        self.fetchCars { items, error in
            self.handleFetchResponse(posts: &posts, items: items, error: error, dispatchGroup: dispatchGroup)
        }
        
        dispatchGroup.enter()
        self.fetchPets { items, error in
            self.handleFetchResponse(posts: &posts, items: items, error: error, dispatchGroup: dispatchGroup)
        }
        
        dispatchGroup.enter()
        self.fetchHomes { items, error in
            self.handleFetchResponse(posts: &posts, items: items, error: error, dispatchGroup: dispatchGroup)
        }
        
        dispatchGroup.enter()
        self.fetchPeople { items, error in
            self.handleFetchResponse(posts: &posts, items: items, error: error, dispatchGroup: dispatchGroup)
        }
        
        dispatchGroup.notify(queue: .main) {
            completion(posts)
        }
    }
    
    func fetchCars(completion: @escaping (_ cars: [Car]?, _ error: Error?) -> Void) {
        self.firestoreRefrence.collection(self.carsCollectionPath).getDocuments { snapshot, error in
            
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let snapshot = snapshot else {
                return
            }
            
            var cars = [Car]()
            snapshot.documents.forEach { document in
                let car = Car(firestoreData: document.data())
                cars.append(car)
            }
            completion(cars, nil)
        }
    }
    
    func fetchHomes(completion: @escaping (_ homes: [Home]?, _ error: Error?) -> Void) {
        self.firestoreRefrence.collection(self.homesCollectionPath).getDocuments { snapshot, error in
            
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let snapshot = snapshot else {
                return
            }
            
            var homes = [Home]()
            snapshot.documents.forEach { document in
                let home = Home(firestoreData: document.data())
                homes.append(home)
            }
            completion(homes, nil)
        }
    }
    
    func fetchPeople(completion: @escaping (_ people: [Person]?, _ error: Error?) -> Void) {
        self.firestoreRefrence.collection(self.peopleCollectionPath).getDocuments { snapshot, error in
            
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let snapshot = snapshot else {
                return
            }
            
            var people = [Person]()
            snapshot.documents.forEach { document in
                let person = Person(firestoreData: document.data())
                people.append(person)
            }
            completion(people, nil)
        }
    }
    
    func fetchPets(completion: @escaping (_ pets: [Pet]?, _ error: Error?) -> Void) {
        self.firestoreRefrence.collection(self.petsCollectionPath).getDocuments { snapshot, error in
            
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let snapshot = snapshot else {
                return
            }
            
            var pets = [Pet]()
            snapshot.documents.forEach { document in
                let pet = Pet(firestoreData: document.data())
                pets.append(pet)
            }
            completion(pets, nil)
        }
    }
    
    private func handleFetchResponse(posts: inout [Post],
                                     items: [Post]?,
                                     error: Error?,
                                     dispatchGroup: DispatchGroup) {
        
        guard let items = items else {
            dispatchGroup.leave()
            return
        }
        
        posts.append(contentsOf: items)
        dispatchGroup.leave()
    }
}
