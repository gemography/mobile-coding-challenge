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
    private var numberOfStars     : Int?
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
    
    func getNumberOfStars()->Int{ return self.numberOfStars ?? 0 }
    
    func getShortNumberOfStars()->String{ return self.shortNumberOfStars ?? "" }
    
    private func setNumberOfStars(numberOfStars: Int){
        
        self.numberOfStars      = numberOfStars
        self.shortNumberOfStars = numberOfStars.shortValue
        
    }
    
}

extension GithubRepositoryEntity{
    
    convenience init(id: Int, name: String, description: String, ownerName: String, numberOfStars: Int) {
        self.init()
        
        self.id            = id
        self.name          = name
        self.description   = description
        self.ownerName     = ownerName
        self.setNumberOfStars(numberOfStars: numberOfStars)
        
    }
    
    static func getFakeData() -> [GithubRepositoryEntity]{
        
        var githubRepos: [GithubRepositoryEntity] = []
        
        for i in 0..<100 {
            
            githubRepos.append(
                .init(
                    id: i,
                    name: "Repository number \(i)",
                    description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                    ownerName: "Owner number \(i)",
                    numberOfStars: i * 100000
                )
            )
            
        }
        
        return githubRepos
        
    }
    
}
