//
//  UIViewController + Extension.swift
//  mobile-coding-challenge
//
//  Created by Mobile on 9/19/20.
//  Copyright © 2020 Zakariae. All rights reserved.
//

import UIKit

extension UIViewController{
    
    func showSimpleAlert(title: String, message: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let okAlertAction = UIAlertAction(title: "ok".localized, style: .default)
        
        alert.addAction(okAlertAction)
        
        self.present(alert, animated: true)
        
    }
    
}
