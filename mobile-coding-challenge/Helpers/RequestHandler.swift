//
//  RequestHandler.swift
//  mobile-coding-challenge
//
//  Created by Mobile on 9/19/20.
//  Copyright © 2020 Zakariae. All rights reserved.
//

import Foundation
import Moya

enum RequestHandler{
    case getMostGithubRepos(created_at: String, page: Int)
}

extension RequestHandler: TargetType{
    
    var baseURL: URL {
        return URL(string: "https://api.github.com/search/repositories")!
    }
    
    var path: String {
        switch self{
            case .getMostGithubRepos(_, _):
                return ""
        }
    }
    
    var method: Moya.Method {
        switch self{
            case .getMostGithubRepos:
                return .get
        }
    }
    
    var sampleData: Data { return .init() }
    
    var task: Task {
        switch self{
            case .getMostGithubRepos(let created_at, let page):
                return .requestParameters(
                    parameters: [
                        "q"    : "created:>\(created_at)",
                        "page" : page,
                        "sort" : "stars",
                        "order": "desc"
                    ],
                    encoding: URLEncoding.queryString
                )
        }
    }
    
    var headers: [String : String]? {
        switch self{
            case .getMostGithubRepos(_, _):
                return ["Content-type": "application/json"]
        }
    }

}
