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
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.mostStarredReposTableView)
        
        NSLayoutConstraint.activate([
        
            self.mostStarredReposTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.mostStarredReposTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.mostStarredReposTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.mostStarredReposTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
            
        ])
        
    }
    
}
