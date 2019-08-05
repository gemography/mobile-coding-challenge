//
//  WebService.swift
//  mobile-coding-challenge
//
//  Created by Talha on 05/08/2019.
//  Copyright © 2019 Talha. All rights reserved.
//

import Foundation
import Alamofire
import Freddy

class WebService {
    
    //MARK: - callService
    class func callService(queryString: String, success: @escaping ([GitHubRepo]) -> Void, failure: @escaping (String) -> Void) {
        
        let gitHubURL = "https://api.github.com/search/repositories?" + queryString

        Alamofire.request(gitHubURL).responseJSON { (response) in
            if response.result.isSuccess {
                do {
                    let trueJson = try JSON(data: response.data!)
                    do {
                        let totalCount = try trueJson.getInt(at: "total_count")
                        if totalCount == 0 {
                            failure("No Records Available")
                            return
                        }
                    } catch {
                        failure("No Records Available")
                        return
                    }
                    let responseArray = try trueJson.getArray(at: "items")
                    let gitRepoResponseArray = try responseArray.map { (json) in
                        return try GitHubRepo(json: json)
                    }
                    success(gitRepoResponseArray)
                } catch let error {
                    failure(error.localizedDescription)
                }
            } else {
                failure(response.result.error!.localizedDescription)
            }
        }
    }

}
