//
//  File.swift
//  mobile-coding-challenge
//
//  Created by Mobile on 9/19/20.
//  Copyright © 2020 Zakariae. All rights reserved.
//

import UIKit

extension Date{
    
    func formattedDate(using dateFormat: String)->String{
        
        let dateFormatter        = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let formattedStringDate  = dateFormatter.string(from: self)
        
        return formattedStringDate
        
    }
    
}
