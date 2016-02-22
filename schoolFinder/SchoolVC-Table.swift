//
//  SchoolVC-Table.swift
//  schoolFinder
//
//  Created by Jonathan Yu on 2/16/16.
//  Copyright © 2016 Jonathan Yu. All rights reserved.
//

import Foundation
import AsyncDisplayKit
import SafariServices

extension SchoolViewController: ASTableDelegate, ASTableDataSource {
    
    func prepareTable() {
        schoolTable = ASTableView(frame: view.bounds, style: UITableViewStyle.Plain, asyncDataFetching: true)
        schoolTable.asyncDataSource = self
        schoolTable.asyncDelegate = self
        view.addSubview(schoolTable)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schoolPropertyKey.count
    }
    
    func tableView(tableView: ASTableView, nodeForRowAtIndexPath indexPath: NSIndexPath) -> ASCellNode {
        let labelValue = schoolPropertyKey[indexPath.row] as String!
        let valueValue = selectedSchool.print_value(labelValue)
        let cell = ProfileDataCellNode(label: labelValue.lowercaseString, value: valueValue)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let labelValue = schoolPropertyKey[indexPath.row] as String!
        let schoolURL = "http://\(selectedSchool.print_value(labelValue))"
        if labelValue == "SCHOOL_URL" {
            let svc = SFSafariViewController(URL: NSURL(string: schoolURL)!)
            self.presentViewController(svc, animated: true, completion: nil)
        }
    }
    
}