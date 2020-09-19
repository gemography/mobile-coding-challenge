//
//  MostStarredGithubReposRouter.swift
//  mobile-coding-challenge
//
//  Created by Mobile on 9/19/20.
//  Copyright © 2020 Zakariae. All rights reserved.
//

import UIKit

class MostStarredGithubReposRouter: PresenterToMostStarredGithubReposRouterProtocol{
    
    static func createModule() -> UIViewController {
        
        let mostStarredGithubReposView       = MostStarredGithubReposView()
        let mostStarredGithubReposInteractor = MostStarredGithubReposInteractor()
        let mostStarredGithubReposRouter     = MostStarredGithubReposRouter()
        
        let mostStarredGithubReposPresenter  = MostStarredGithubReposPresenter(
            view: mostStarredGithubReposView,
            interactor: mostStarredGithubReposInteractor,
            router: mostStarredGithubReposRouter
        )
        
        mostStarredGithubReposView.presenter       = mostStarredGithubReposPresenter
        mostStarredGithubReposInteractor.presenter = mostStarredGithubReposPresenter
        
        return mostStarredGithubReposView
        
    }
    
}
