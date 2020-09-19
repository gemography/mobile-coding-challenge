//
//  MostStarredGithubReposView.swift
//  mobile-coding-challenge
//
//  Created by Mobile on 9/19/20.
//  Copyright © 2020 Zakariae. All rights reserved.
//

import UIKit

class MostStarredGithubReposView: MostStarredGithubReposUI, PresenterToMostStarredGithubReposViewProtocol{
    
    var presenter: ViewToMostStarredGithubReposPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mostStarredReposTableView.dataSource = self
        self.mostStarredReposTableView.delegate   = self
        self.mostStarredReposTableView.register(MostStarredGithubReposTableViewCell.self, forCellReuseIdentifier: "\(MostStarredGithubReposTableViewCell.self)")
        
        self.refreshControl.addTarget(self, action: #selector(self.refreshMostStarredGithubReposData), for: .valueChanged)
        
        self.presenter.viewDidLoad()
        
    }
    
    func reloadData() {
        self.mostStarredReposTableView.reloadData()
    }
    
    func showLoader() {
        self.mostStarredReposTableView.isUserInteractionEnabled = false
        self.mostStarredReposTableView.separatorStyle = .none
        self.loadingIndicatorView.startAnimating()
    }
    
    func hideLoader() {
        self.mostStarredReposTableView.isUserInteractionEnabled = true
        self.mostStarredReposTableView.separatorStyle = .singleLine
        self.loadingIndicatorView.stopAnimating()
        self.refreshControl.endRefreshing()
    }
    
    func showResponseError(){
        self.showAlert(title: "errors.something_went_wrong".localized, message: "mostStarredGithubRepos.errors.while_fetching_for_repos_description".localized)
    }
    
    @objc
    func refreshMostStarredGithubReposData(){
        self.presenter.interactor.getMostStarredGithubRepos(from: 1, isToUsePullRefresh: true)
    }
    
}

extension MostStarredGithubReposView: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.mostStarredGithubRepos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let mostStarredGithubReposCell = tableView.dequeueReusableCell(withIdentifier: "\(MostStarredGithubReposTableViewCell.self)", for: indexPath) as! MostStarredGithubReposTableViewCell
        
        let mostStarredGithubRepo = self.presenter.mostStarredGithubRepos[indexPath.row]
        
        mostStarredGithubReposCell.fillView(
            repositoryName: mostStarredGithubRepo.getName(),
            repositoryDescription: mostStarredGithubRepo.getDescription(),
            repositoryOwnerImageLink: mostStarredGithubRepo.getOwnerImageURL(),
            repositoryOwnerName: mostStarredGithubRepo.getOwnerName(),
            repositoryNumberOfStars: mostStarredGithubRepo.getShortNumberOfStars()
        )
        
        if indexPath.row == self.presenter.mostStarredGithubRepos.count - 1 {
        
            let totalNumberOfMostStarredGithubRepos = self.presenter.totalNumberOfMostStarredGithubRepos
            
            if totalNumberOfMostStarredGithubRepos != -1 && totalNumberOfMostStarredGithubRepos ?? -1 > self.presenter.mostStarredGithubRepos.count{
                
                self.presenter.interactor.getMostStarredGithubRepos(from: self.presenter.activePage, isToUsePullRefresh: false)
                
            }
            
        }
        
        return mostStarredGithubReposCell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
