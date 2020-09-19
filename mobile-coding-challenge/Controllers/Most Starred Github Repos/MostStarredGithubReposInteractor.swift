//
//  MostStarredGithubReposInteractor.swift
//  mobile-coding-challenge
//
//  Created by Mobile on 9/19/20.
//  Copyright © 2020 Zakariae. All rights reserved.
//

import Foundation

class MostStarredGithubReposInteractor: PresenterToMostStarredGithubReposInteractorProtocol{
    
    var presenter: InteractorToMostStarredGithubReposPresenterProtocol!
    
    func getMostStarredGithubRepos() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            
            self.presenter.mostStarredGithubReposSuccessFetch(repos: GithubRepositoryEntity.getFakeData())
            
        }
        
    }
    
    
}
