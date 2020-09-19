//
//  MostStarredGithubReposInteractor.swift
//  mobile-coding-challenge
//
//  Created by Mobile on 9/19/20.
//  Copyright © 2020 Zakariae. All rights reserved.
//

import Moya
import SwiftyJSON

class MostStarredGithubReposInteractor: PresenterToMostStarredGithubReposInteractorProtocol{
    
    var presenter: InteractorToMostStarredGithubReposPresenterProtocol!
    
    func getMostStarredGithubRepos(from page: Int, isToUsePullRefresh: Bool) {
        
        let requestHandler = MoyaProvider<RequestHandler>()
        
        if let previousMonthDate    = Calendar.current.date(byAdding: .month, value: -1, to: Date()){
        
            requestHandler.request(.getMostGithubRepos(created_at: previousMonthDate.formattedDate(using: "YYYY-MM-dd"), page: page)){ result in
            
            switch result {
                case let .success(moyaResponse):
                    
                    var mostStarredGithubRepos: [GithubRepositoryEntity] = []
                    
                    if let _mostStarredGithubRepos = JSON(moyaResponse.data)["items"].array{
                        
                        for _mostStarredGithubRepo in _mostStarredGithubRepos{
                            
                            if let mostStarredGithubRepo = GithubRepositoryEntity(from: _mostStarredGithubRepo){
                                
                                mostStarredGithubRepos.append(mostStarredGithubRepo)
                                
                            }
                            
                        }
                        
                    }
                
                    self.presenter.mostStarredGithubReposSuccessFetch(repos: mostStarredGithubRepos, isToUsePullRefresh: isToUsePullRefresh)
                
                
                default:
                    
                    self.presenter.mostStarredGithubReposSuccessFailure()
                
            }
        }
            
            return
            
        }
        
        self.presenter.mostStarredGithubReposSuccessFailure()
        
    }
    
    
}
