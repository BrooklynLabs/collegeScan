//
//  SavedVC.swift
//  schoolFinder
//
//  Created by Jonathan Yu on 2/8/16.
//  Copyright © 2016 Jonathan Yu. All rights reserved.
//

import Foundation
import AsyncDisplayKit
import Whisper

class SavedViewController: UIViewController, ASTableDataSource, ASTableDelegate {
    var tableView: ASTableView!
    var savedSchools: [SchoolViewModel]!
    var messageHelper = MessageHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Saved Schools"
        savedSchools = []
        tableView = ASTableView(frame: view.bounds)
        tableView.asyncDataSource = self
        tableView.asyncDelegate = self
        view.addSubview(tableView)
        
        if savedSchools.count == 0 {
            Whisper(messageHelper.emptyMessage, to: self.navigationController!, action: .Present)
        }
    }
    
    func tableView(tableView: ASTableView, nodeForRowAtIndexPath indexPath: NSIndexPath) -> ASCellNode {
        let schoolAtIndexPath = savedSchools[indexPath.row]
        let schoolNode = SchoolNode(result: schoolAtIndexPath)
        
        return schoolNode
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedSchools.count
    }

    
}