//
//  MostStarredGithubReposProtocol.swift
//  mobile-coding-challenge
//
//  Created by Mobile on 9/19/20.
//  Copyright © 2020 Zakariae. All rights reserved.
//

import UIKit

protocol PresenterToMostStarredGithubReposViewProtocol{}

protocol ViewToMostStarredGithubReposPresenterProtocol{}

protocol PresenterToMostStarredGithubReposInteractorProtocol{}

protocol InteractorToMostStarredGithubReposPresenterProtocol{}

protocol PresenterToMostStarredGithubReposRouterProtocol{
    static func createModule() -> UIViewController
}
