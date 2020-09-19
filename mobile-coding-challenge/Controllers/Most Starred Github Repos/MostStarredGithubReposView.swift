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
        self.mostStarredReposTableView.tableFooterView = nil
    }
    
    func showResponseError(){
        self.loadingIndicatorView.stopAnimating()
        self.refreshControl.endRefreshing()
        self.mostStarredReposTableView.tableFooterView = nil
        self.showSimpleAlert(title: "errors.something_went_wrong".localized, message: "mostStarredGithubRepos.errors.while_fetching_for_repos_description".localized)
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == self.presenter.mostStarredGithubRepos.count - 1 {
        
            let totalNumberOfMostStarredGithubRepos = self.presenter.totalNumberOfMostStarredGithubRepos
            
            if totalNumberOfMostStarredGithubRepos != -1 && totalNumberOfMostStarredGithubRepos ?? -1 > self.presenter.mostStarredGithubRepos.count{
                
                let _view = UIView(
                    frame: .init(
                        x: 0,
                        y: 0,
                        width: tableView.contentSize.width,
                        height: 40
                    )
                )
                
                let indicatorView = UIActivityIndicatorView(frame: .init(
                        x: _view.frame.width / 2,
                        y: _view.frame.height / 2,
                        width: 20,
                        height: 20
                    )
                )
                
                indicatorView.startAnimating()
                _view.addSubview(indicatorView)
                
                self.mostStarredReposTableView.tableFooterView = _view
                
                self.presenter.interactor.getMostStarredGithubRepos(from: self.presenter.activePage, isToUsePullRefresh: false)
                
            }
            
        }
        
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
        
        return mostStarredGithubReposCell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
