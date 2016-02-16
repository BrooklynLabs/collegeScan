//
//  SchoolVC-Table.swift
//  schoolFinder
//
//  Created by Jonathan Yu on 2/16/16.
//  Copyright © 2016 Jonathan Yu. All rights reserved.
//

import Foundation
import UIKit

extension SchoolViewController: UITableViewDataSource, UITableViewDelegate {
    
    func prepareTable() {
        schoolTable = UITableView(frame: view.frame)
        schoolTable.dataSource = self
        schoolTable.delegate = self
        schoolTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "dataCell")
        view.addSubview(schoolTable)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schoolPropertyKey.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "dataCell")
        cell.textLabel?.text = schoolPropertyValue[indexPath.row] as String!
        cell.detailTextLabel?.text = schoolPropertyKey[indexPath.row]
        
        return cell
    }
    
}