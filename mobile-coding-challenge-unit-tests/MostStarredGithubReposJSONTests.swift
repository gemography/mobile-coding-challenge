//
//  MostStarredGithubReposJSONTests.swift
//  mobile-coding-challenge-unit-tests
//
//  Created by Mobile on 9/20/20.
//  Copyright © 2020 Zakariae. All rights reserved.
//

import XCTest
import Moya
import SwiftyJSON

class MostStarredGithubReposJSONTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        self.continueAfterFailure = false
        
    }

    func testForIsTheMostStarredGithubReposJSONCorrect(){
        
        let expectation = self.expectation(description: "theMostStarredGithubReposJSONExpectation")
        
        var previousMonthDate: Date?
        
        if let _previousMonthDate    = Calendar.current.date(byAdding: .month, value: -1, to: Date()){
            
            previousMonthDate = _previousMonthDate
            
            let requestProvider = MoyaProvider<RequestHandler>()
            
            requestProvider.request(.getMostGithubRepos(created_at: previousMonthDate!.formattedDate(using: "YYYY-MM-dd"), page: 1)) { result in
                
                switch result {
                    case let .success(moyaResponse):
                        
                        let responseJSON = JSON(moyaResponse.data)
                        
                        var mostStarredGithubRepos: [JSON]?
                        var totalCount            : Int?
                        
                        if moyaResponse.statusCode == 200{
                        
                            if let _mostStarredGithubRepos = responseJSON["items"].array{
                                
                                if let _totalCount = responseJSON["total_count"].int{
                                
                                    mostStarredGithubRepos = _mostStarredGithubRepos
                                    
                                    totalCount = _totalCount
                                    
                                    var totalChecks: Int = 0
                                    
                                    for _mostStarredGithubRepo in mostStarredGithubRepos!{
                                        
                                        let mostStarredGithubRepo = GithubRepositoryEntity(from: _mostStarredGithubRepo)
                                        
                                        XCTAssertNotNil(mostStarredGithubRepo, "TEST: IS THE MOST STARRED GITHUB REPOS JSON CORRECT => Response JSON is not fit : Something missed from GithubRepositoryEntity")
                                        
                                        totalChecks += 1
                                        
                                    }
                                    
                                    XCTAssertEqual(totalChecks, mostStarredGithubRepos!.count)
                                    expectation.fulfill()
                                    
                                    return
                                    
                                }
                                
                                XCTAssertNotNil(totalCount, "TEST: IS THE MOST STARRED GITHUB REPOS JSON CORRECT => Response JSON is not fit : (total_count => Int) is not exists or is not an integer.")
                                
                                return
                                
                            }
                        
                            XCTAssertNotNil(mostStarredGithubRepos, "TEST: IS THE MOST STARRED GITHUB REPOS JSON CORRECT => Response JSON is not fit : [items] is not exists or is not an array.")
                            
                            return
                    
                        }
                        
                        XCTAssertEqual(moyaResponse.statusCode, 200, "TEST: IS THE MOST STARRED GITHUB REPOS JSON CORRECT => Created_at is not fit")
                        expectation.fulfill()
                        
                    
                    default:
                        expectation.fulfill()
                    
                }
                
            }
            
            self.wait(for: [expectation], timeout: 10.0)
            
            return
            
        }
        
        XCTAssertNotNil(previousMonthDate, "TEST: IS THE MOST STARRED GITHUB REPOS JSON CORRECT => Previous month date is incorrect")
        
    }

}
