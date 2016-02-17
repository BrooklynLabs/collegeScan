//
//  SchoolVC-Table.swift
//  schoolFinder
//
//  Created by Jonathan Yu on 2/16/16.
//  Copyright © 2016 Jonathan Yu. All rights reserved.
//

import Foundation
import AsyncDisplayKit

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
        let label = schoolPropertyKey[indexPath.row] as String!
        let value = selectedSchool.print_value(label)
        let cell = ProfileDataCellNode(label: label, value: value)
        
        return cell
    }
    
    
}