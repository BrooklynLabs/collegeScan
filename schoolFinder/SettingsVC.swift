//
//  SettingsVC.swift
//  schoolFinder
//
//  Created by Jonathan Yu on 2/12/16.
//  Copyright © 2016 Jonathan Yu. All rights reserved.
//

import Foundation
import UIKit
import SafariServices

class SettingsVC: UITableViewController {
    var settingItems: [[String]] = [["See Intro Screen Again"], ["AsyncDisplayKit", "EAIntroView", "SnapKit", "DZNEmptyDataSet", "Realm", "Whisper", "AlamoFire", "AlamofireObjectMapper"]]
    var podURLs: [String]! = ["http://asyncdisplaykit.org", "https://github.com/ealeksandrov/EAIntroView", "https://github.com/SnapKit/SnapKit", "https://github.com/dzenbot/DZNEmptyDataSet", "https://realm.io/", "https://github.com/hyperoslo/Whisper", "https://github.com/Alamofire/Alamofire", "https://github.com/tristanhimmelman/AlamofireObjectMapper"]
    
    override func viewDidLoad() {
        tableView = UITableView(frame: tableView.frame, style: .Grouped)
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0:
            return "Settings"
        case 1:
            return "Acknowledgements"
        default:
            return "Error:"
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        
        cell.backgroundColor = UIColor.clearColor()
        cell.textLabel?.text = self.settingItems[indexPath.section][indexPath.row]
        
        if indexPath.section == 1 {
            cell.detailTextLabel?.text = self.podURLs[indexPath.row]
        }
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.settingItems[section].count
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if indexPath.section == 0 {
            print("Do something")
        } else if indexPath.section == 1 {
            let selectedURL = self.podURLs[indexPath.row]
            let svc = SFSafariViewController(URL: NSURL(string: selectedURL)!)
            self.presentViewController(svc, animated: true, completion: nil)
        }
    }
}