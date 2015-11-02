//
//  TrendsViewController.swift
//  #ofTheDay
//
//  Created by Julien on 31/10/2015.
//  Copyright © 2015 epsi. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

struct TwitterTrends {
    var title:String
}

class TrendsViewController: UITableViewController {
    
    var trends:Array<TwitterTrends> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let headers = [
            "Authorization": "OAuth oauth_consumer_key=qvEelRp2nbcbDVim58cfH9j2z, oauth_nonce=ab6e56c63434b562160c349cfc1cea2f, oauth_signature=NP%2FUTd1Tj4%2Fz%2B5q921Rqt5fiOR8%3D, oauth_signature_method=HMAC-SHA1, oauth_timestamp=1446496788, oauth_version=1.0"
        ]
        
        Alamofire.request(.GET, "https://api.twitter.com/1.1/trends/place.json?id=1", headers: headers)
        .responseJSON { result in
            print(result)
            let responseData = JSON(data: result.data!)
            let trendsData = responseData[0]["trends"]
            
            for (_, trendData) in trendsData {
                let title = trendData["name"].string!
                let trend = TwitterTrends(title: title)
                
                self.trends.append(trend)
            }
            
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.trends.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TrendCell", forIndexPath: indexPath) as! TrendViewCell
        
        cell.trendTitle.text = self.trends[indexPath.row].title
        
        return cell
    }
    
    /*override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let post = self.trends[indexPath.row]
        //UIApplication.sharedApplication().openURL(NSURL(string: post.url)!)
    }*/
}
