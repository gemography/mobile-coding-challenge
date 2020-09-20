//
//  MostStarredGithubReposUI.swift
//  mobile-coding-challenge
//
//  Created by Mobile on 9/19/20.
//  Copyright © 2020 Zakariae. All rights reserved.
//

import UIKit

class MostStarredGithubReposUI: UIViewController{
    
    let mostStarredReposTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.separatorInset  = .zero
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    let loadingIndicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.color = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        refreshControl.attributedTitle = NSAttributedString(string: "pull_to_refresh".localized)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.mostStarredReposTableView)
        self.view.addSubview(self.loadingIndicatorView)
        self.mostStarredReposTableView.refreshControl = self.refreshControl
        
        NSLayoutConstraint.activate([
        
            self.mostStarredReposTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.mostStarredReposTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.mostStarredReposTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.mostStarredReposTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            self.loadingIndicatorView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.loadingIndicatorView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            
        ])
        
        self.navigationController?.navigationBar.topItem?.title = "mostStarredGithubRepos.trending_repos".localized
        
    }
    
}
