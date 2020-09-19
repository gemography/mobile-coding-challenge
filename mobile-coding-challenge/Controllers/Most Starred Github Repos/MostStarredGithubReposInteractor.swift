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
                    
                    let responseJSON = JSON(moyaResponse.data)
                    
                    var mostStarredGithubRepos: [GithubRepositoryEntity] = []
                    var totalCount: Int = 0
                    
                    if  let _mostStarredGithubRepos = responseJSON["items"].array,
                        let _totalCount = responseJSON["total_count"].int{
                        
                        totalCount = _totalCount
                        
                        for _mostStarredGithubRepo in _mostStarredGithubRepos{
                            
                            if let mostStarredGithubRepo = GithubRepositoryEntity(from: _mostStarredGithubRepo){
                                
                                mostStarredGithubRepos.append(mostStarredGithubRepo)
                                
                            }
                            
                        }
                        
                    }
                
                    self.presenter.mostStarredGithubReposSuccessFetch(repos: mostStarredGithubRepos, isToUsePullRefresh: isToUsePullRefresh, totalCount: totalCount)
                
                
                default:
                    
                    self.presenter.mostStarredGithubReposSuccessFailure()
                
            }
        }
            
            return
            
        }
        
        self.presenter.mostStarredGithubReposSuccessFailure()
        
    }
    
    
}
