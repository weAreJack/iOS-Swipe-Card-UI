//
//  HomePresenter.swift
//  swipe_card_UI
//
//  Created by Jack Smith on 15/06/2020.
//  Copyright © 2020 jack-adam-smith. All rights reserved.
//

import Foundation

protocol HomePresenterProtocol {
    func checkForMatch(post: CardViewModel)
    func fetchPosts()
}

protocol HomePresenterDelegate: class {
    func homePresenterDidBeginPostFetch(_ homePresenter: HomePresenter)
    func homePresenterDidFetchPost(_ homePresenter: HomePresenter, post: CardViewModel)
    func homePresenterDidFindMatch(_ homePresenter: HomePresenter, matchedViewModel: MatchedViewModel)
}

class HomePresenter {
    
    // MARK: - Methods
    
    private var view: HomePresenterDelegate
    private let user = Person()
    
    // MARK: - Init
    
    init(_ view: HomePresenterDelegate) {
        self.view = view
    }
}

extension HomePresenter: HomePresenterProtocol {
    
    func checkForMatch(post: CardViewModel) {
        let matchedViewModel = MatchedViewModel(user: self.user, post: post)
        self.view.homePresenterDidFindMatch(self, matchedViewModel: matchedViewModel)
    }
    
    func fetchPosts() {
        self.view.homePresenterDidBeginPostFetch(self)
        FirestoreService.shared.fetchPosts { [weak self] posts in
            guard let self = self, var posts = posts else {
                return
            }
            
            posts.shuffle()
            posts.forEach { post in
                let viewModel = (post as! ProducesCardViewModel).cardViewModel
                self.view.homePresenterDidFetchPost(self, post: viewModel)
            }
        }
    }
}
