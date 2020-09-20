//
//  Int + Extension.swift
//  mobile-coding-challenge
//
//  Created by Mobile on 9/19/20.
//  Copyright © 2020 Zakariae. All rights reserved.
//

import Foundation

extension Int{
    
    var shortValue: String{
        
        let num: Double = Double(abs(self))

        if (num < 1000.0){
            return "\(self)"
        }
        
        let sign      : String = (self < 0) ? "-" : ""
        let exp       : Int      = Int(log10(num) / 3.0 )
        let units     : [String] = ["K","M"]
        let roundedNum: Double   = round(10 * num / pow(1000.0, Double(exp))) / 10

        if exp <= units.count{
            return "\(sign)\(roundedNum)\(units[exp-1])"
        }
        
        return "+\(Int(roundedNum))..."
        
    }
    
}
