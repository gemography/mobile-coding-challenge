//
//  Entity.swift
//  mobile-coding-challenge
//
//  Created by Talha on 05/08/2019.
//  Copyright © 2019 Talha. All rights reserved.
//

import Foundation
import Freddy

struct GitHubRepo {
    
    var repoId: Int
    var repoName: String
    var repoDescription: String
    var repoOwner: String
    var repoAvatar: String
    var repoStars: Int
    
}

extension GitHubRepo: JSONDecodable {
    
    init(json: JSON) throws {
        repoId = try json.getInt(at: "id")
        repoName = try json.getString(at: "name")
        if json["description"] != nil && json["description"] != JSON.null {
            repoDescription = try json.getString(at: "description")
        } else {
            repoDescription = ""
        }
        repoOwner = try json.getString(at: "owner", "login")
        repoAvatar = try json.getString(at: "owner", "avatar_url")
        repoStars = try json.getInt(at: "stargazers_count")
    }
    
}
