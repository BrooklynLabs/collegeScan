//
//  SchoolTableViewController.swift
//  schoolFinder
//
//  Created by Jonathan Yu on 2/24/16.
//  Copyright © 2016 Jonathan Yu. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class SchoolTableViewController: UIViewController, ASTableViewDataSource, ASTableViewDelegate {
    
    var tableView: ASTableView!
    var longPress: UILongPressGestureRecognizer?
    
    var schoolDataSource: [SchoolViewModel] = []
    var messageHelper = MessageHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = ASTableView(frame: view.frame)
        tableView.asyncDataSource = self
        tableView.asyncDelegate = self
        
        view.addSubview(tableView)
        setupLongPress()
    }
    
    func setupLongPress() {
        let longPress = UILongPressGestureRecognizer(target: self, action: "firstCollegeSelected:")
        tableView.addGestureRecognizer(longPress)
    }
    
    func firstCollegeSelected(sender: AnyObject) {
        print("hello")
    }
    
    func tableView(tableView: ASTableView, nodeForRowAtIndexPath indexPath: NSIndexPath) -> ASCellNode {
        let schoolAtIndexPath = schoolDataSource[indexPath.row]
        return SchoolNode(result: schoolAtIndexPath)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schoolDataSource.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let selectedSchool = schoolDataSource[indexPath.row]
        let selectedSchoolController = SchoolViewController(schoolID: selectedSchool.ID)
        
        self.navigationController?.pushViewController(selectedSchoolController, animated: true)
    }

    
}