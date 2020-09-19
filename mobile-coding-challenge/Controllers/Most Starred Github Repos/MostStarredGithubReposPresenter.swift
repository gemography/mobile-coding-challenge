//
//  MostStarredGithubReposPresenter.swift
//  mobile-coding-challenge
//
//  Created by Mobile on 9/19/20.
//  Copyright © 2020 Zakariae. All rights reserved.
//

import Foundation
class MostStarredGithubReposPresenter: ViewToMostStarredGithubReposPresenterProtocol, InteractorToMostStarredGithubReposPresenterProtocol{
    
    weak var view: PresenterToMostStarredGithubReposViewProtocol!
    var interactor: PresenterToMostStarredGithubReposInteractorProtocol!
    var router: PresenterToMostStarredGithubReposRouterProtocol!
    var mostStarredGithubRepos: [GithubRepositoryEntity]! = []
    
    var numberOfRows: Int!{
        return self.mostStarredGithubRepos.count
    }
    
    convenience init(view: PresenterToMostStarredGithubReposViewProtocol, interactor: PresenterToMostStarredGithubReposInteractorProtocol, router: PresenterToMostStarredGithubReposRouterProtocol) {
        self.init()

        self.view       = view
        self.interactor = interactor
        self.router     = router
        
    }
    
    func viewDidLoad() {
        
        self.mostStarredGithubRepos = []
        self.view.showLoader()
        self.interactor.getMostStarredGithubRepos()
        
    }
    
    func mostStarredGithubReposSuccessFetch(repos: [GithubRepositoryEntity]) {
        
        self.view.hideLoader()
        self.mostStarredGithubRepos = repos
        self.view.reloadData()
        
    }
    
    func mostStarredGithubReposSuccessFailure() {
        
        self.view.hideLoader()
        self.view.showResponseError()
        
    }
    
}
