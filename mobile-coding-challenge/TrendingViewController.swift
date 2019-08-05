//
//  TrendingViewController.swift
//  mobile-coding-challenge
//
//  Created by Talha on 03/08/2019.
//  Copyright © 2019 Talha. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class TrendingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var trendingTableView: UITableView!
    
    var trendingData: [GitHubRepo]?
    var isScrollViewBegin = true
    var isServiceRunning = false
    var page = 1
    var noRecords = false

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.noRecords = false
        
        self.trendingTableView.estimatedRowHeight = 150
        self.trendingTableView.rowHeight = 150
        
        self.loadData(queryString: self.getQueryString())
    }
    
    
    // MARK : UITableView Delegate Methods
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "trandingCell", for: indexPath)
        guard let trending = self.trendingData else { return cell }
        
        let repository = trending[indexPath.row]
        
        if let repoName:UILabel = cell.viewWithTag(1) as? UILabel {
            repoName.text = repository.repoName
        }
        if let repoDescription:UILabel = cell.viewWithTag(2) as? UILabel {
            repoDescription.text = repository.repoDescription
        }
        if let repoAvatar:UIImageView = cell.viewWithTag(3) as? UIImageView {
            let imageUrl:URL = URL(string: repository.repoAvatar)!
            repoAvatar.af_setImage(withURL: imageUrl, placeholderImage: nil, imageTransition: .crossDissolve(0.5), runImageTransitionIfCached: true, completion: nil)
        }
        if let repoOwner:UILabel = cell.viewWithTag(4) as? UILabel {
            repoOwner.text = repository.repoOwner
        }
        if let repoStars:UILabel = cell.viewWithTag(5) as? UILabel {
            repoStars.text = formatPoints(num: Double(repository.repoStars))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let tredingDataCount = self.trendingData?.count else { return 0 }
        return tredingDataCount
    }
    
    //MARK : Class Methods
    
    @objc func getQueryString(page: Int = 1) -> String {
        let today = Date()
        let thirtyDaysBeforeToday = Calendar.current.date(byAdding: .day, value: -30, to: today)!
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        
        let thirtyDaysBeforeTodayInString = dateFormatterGet.string(from: thirtyDaysBeforeToday)
        
        var queryString = "q=created:%3E" + thirtyDaysBeforeTodayInString + "&sort=stars&order=desc"
        if page > 1 {
            queryString = queryString + "&page=" + String(page)
        }
        return queryString
    }
    
    @objc func loadData(queryString: String) {
        if self.noRecords == false {
            activityIndicator.startAnimating()
            isServiceRunning = true
            self.trendingTableView.isUserInteractionEnabled = false
            WebService.callService(queryString: queryString, success: {(result) in
                self.isServiceRunning = false
                if self.trendingData == nil {
                    self.trendingData = result
                } else {
                    self.trendingData?.append(contentsOf: result)
                }
                self.trendingTableView.reloadData()
                self.activityIndicator.stopAnimating()
                self.isScrollViewBegin = false
                self.trendingTableView.isUserInteractionEnabled = true
            }, failure: { (error) in
                if error == "No Records Available" {
                    self.noRecords = true
                } else {
                    self.showErrorAlert(message: error)
                }
                self.activityIndicator.stopAnimating()
                self.isScrollViewBegin = false
                self.trendingTableView.isUserInteractionEnabled = true
            })
        }
    }
    
    //MARK : Helper Method
    
    func formatPoints(num: Double) ->String{
        var thousandNum = num/1000
        var millionNum = num/1000000
        if num >= 1000 && num < 1000000{
            if(floor(thousandNum) == thousandNum){
                return("\(Int(thousandNum))k")
            }
            return("\(thousandNum.roundToPlaces(places: 1))k")
        }
        if num > 1000000{
            if(floor(millionNum) == millionNum){
                return("\(Int(thousandNum))k")
            }
            return ("\(millionNum.roundToPlaces(places: 1))M")
        }
        else{
            if(floor(num) == num){
                return ("\(Int(num))")
            }
            return ("\(num)")
        }
    }
    
    func loadMore(scrollView: UIScrollView, isServiceRunning: Bool, isScrollViewBegin: Bool, completion: @escaping () -> Void) {
        
        let offset_: CGPoint = scrollView.contentOffset
        let bounds: CGRect = scrollView.bounds
        let size: CGSize = scrollView.contentSize
        let inset: UIEdgeInsets = scrollView.contentInset
        let y: CGFloat = offset_.y + bounds.size.height - inset.bottom
        let h: CGFloat = size.height
        let reload_distance: CGFloat = 12
        
        if y > h + reload_distance && !isServiceRunning && isScrollViewBegin {
            completion()
        }
    }
    
    func showErrorAlert(message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (_: UIAlertAction) -> Void in
            print("OK pressed on error alert")
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK : Scroll View Delegate Methods
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.loadMore(scrollView: scrollView, isServiceRunning: self.isServiceRunning, isScrollViewBegin: self.isScrollViewBegin, completion: {
            self.page = self.page + 1
            self.loadData(queryString: self.getQueryString(page: self.page))
        })
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isScrollViewBegin = true
    }

}

// MARK : Double Extension

extension Double {
    /// Rounds the double to decimal places value
    mutating func roundToPlaces(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return Darwin.round(self * divisor) / divisor
    }
}

