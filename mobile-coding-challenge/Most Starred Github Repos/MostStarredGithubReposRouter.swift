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
        
        let mostStarredGithubReposView = MostStarredGithubReposView()
        
        return mostStarredGithubReposView
        
    }
    
}
