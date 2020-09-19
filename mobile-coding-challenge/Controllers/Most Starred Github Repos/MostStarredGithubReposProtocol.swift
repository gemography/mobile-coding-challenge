//
//  MostStarredGithubReposProtocol.swift
//  mobile-coding-challenge
//
//  Created by Mobile on 9/19/20.
//  Copyright © 2020 Zakariae. All rights reserved.
//

import UIKit

protocol PresenterToMostStarredGithubReposViewProtocol: class{
    var presenter: ViewToMostStarredGithubReposPresenterProtocol! { get set }
    func showLoader()
    func hideLoader()
    func showResponseError()
    func reloadData()
}

protocol ViewToMostStarredGithubReposPresenterProtocol{
    var view: PresenterToMostStarredGithubReposViewProtocol! { get set }
    var interactor: PresenterToMostStarredGithubReposInteractorProtocol! { get set }
    var router: PresenterToMostStarredGithubReposRouterProtocol! { get set }
    var mostStarredGithubRepos: [GithubRepositoryEntity]! { get set }
    var numberOfRows: Int! { get }
    func viewDidLoad()
}

protocol PresenterToMostStarredGithubReposInteractorProtocol{
    var presenter: InteractorToMostStarredGithubReposPresenterProtocol! { get set }
    func getMostStarredGithubRepos()
}

protocol InteractorToMostStarredGithubReposPresenterProtocol{
    func mostStarredGithubReposSuccessFetch(repos: [GithubRepositoryEntity])
    func mostStarredGithubReposSuccessFailure()
}

protocol PresenterToMostStarredGithubReposRouterProtocol{
    static func createModule()->UIViewController
}
