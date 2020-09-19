//
//  MostStarredGithubReposEntity.swift
//  mobile-coding-challenge
//
//  Created by Mobile on 9/19/20.
//  Copyright © 2020 Zakariae. All rights reserved.
//

import Foundation
import SwiftyJSON

class GithubRepositoryEntity{
    
    private var id                : Int!
    private var name              : String!
    private var description       : String?
    private var ownerImageLink    : String?
    private var ownerName         : String!
    private var numberOfStars     : Int!
    private var shortNumberOfStars: String?
    
    func getId() -> Int{ return self.id }
    
    func getName()->String{ return self.name }
    
    func getDescription()->String{ return self.description ?? "" }
    
    func getOwnerImageURL()->URL?{
        if let imageURL = URL(string: self.ownerImageLink ?? ""){
            return imageURL
        }
        return nil
    }
    
    func getOwnerName()->String{ return self.ownerName }
    
    func getNumberOfStars()->Int{ return self.numberOfStars }
    
    func getShortNumberOfStars()->String{ return self.shortNumberOfStars ?? "" }
    
    private func setNumberOfStars(numberOfStars: Int){
        
        self.numberOfStars      = numberOfStars
        self.shortNumberOfStars = numberOfStars.shortValue
        
    }
    
}

extension GithubRepositoryEntity{
    
    convenience init?(from repoJSON: JSON){
        self.init()
        
        let ownerObject = repoJSON["owner"].dictionaryObject
        
        if  let repoId        = repoJSON["id"].int,
            let repoName      = repoJSON["name"].string,
            let ownerName     = ownerObject?["login"] as? String,
            let numberOfStars = repoJSON["stargazers_count"].int{
            
            self.id            = repoId
            self.name          = repoName
            self.ownerName     = ownerName
            self.setNumberOfStars(numberOfStars: numberOfStars)
            
            if let description = repoJSON["description"].string{
                self.description = description
            }
            
            if let avatarStringURL = ownerObject?["avatar_url"] as? String{
                self.ownerImageLink = avatarStringURL
            }
            
            return
            
        }
        
        return nil
        
    }
    
}
