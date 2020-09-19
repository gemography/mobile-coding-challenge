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
    var totalNumberOfMostStarredGithubRepos: Int! = -1
    var activePage: Int! = 1
    
    convenience init(view: PresenterToMostStarredGithubReposViewProtocol, interactor: PresenterToMostStarredGithubReposInteractorProtocol, router: PresenterToMostStarredGithubReposRouterProtocol) {
        self.init()

        self.view       = view
        self.interactor = interactor
        self.router     = router
        
    }
    
    func viewDidLoad() {
        
        self.mostStarredGithubRepos = []
        self.view.showLoader()
        self.interactor.getMostStarredGithubRepos(from: self.activePage, isToUsePullRefresh: false)
        
    }
    
    func mostStarredGithubReposSuccessFetch(repos: [GithubRepositoryEntity], isToUsePullRefresh: Bool, totalCount: Int) {
        
        self.totalNumberOfMostStarredGithubRepos = totalCount
        
        if isToUsePullRefresh{
            self.mostStarredGithubRepos = repos
        }else{
            self.mostStarredGithubRepos.append(contentsOf: repos)
            self.activePage += 1
        }
        
        self.view.hideLoader()
        self.view.reloadData()
        
    }
    
    func mostStarredGithubReposSuccessFailure() {
        
        self.view.hideLoader()
        self.view.showResponseError()
        
    }
    
}
