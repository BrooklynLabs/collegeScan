//
//  SchoolTableViewController.swift
//  schoolFinder
//
//  Created by Jonathan Yu on 2/24/16.
//  Copyright © 2016 Jonathan Yu. All rights reserved.

//  This is not to be used directly. Subclass for School table related stuff

import Foundation
import AsyncDisplayKit

class SchoolTableViewController: UIViewController, ASTableViewDataSource, ASTableViewDelegate {
    
    var tableView: ASTableView!
    var longPress: UILongPressGestureRecognizer?
    
    var schoolDataSource: [SchoolViewModel] = []
    var schoolComparisonHelper: [String: SchoolViewModel] = [String: SchoolViewModel]()
    var messageHelper = MessageHelper()
    
    var firstSchoolFilled: Bool = false
    var secondSchoolFilled: Bool = false
    var showingCompareButton: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = ASTableView(frame: view.frame)
        tableView.asyncDataSource = self
        tableView.asyncDelegate = self
        
        view.addSubview(tableView)
        setupLongPress()
    }    
    
//    If I do not filter for this state and return a nil then I am going to get a double read.
    func returnLongPressedSchool(senderRecognizer: AnyObject?) -> SchoolViewModel? {
        if let longPress = senderRecognizer as? UILongPressGestureRecognizer {
            let state = longPress.state
            let locationInView = longPress.locationInView(tableView)
            let pressedIndexPath = tableView.indexPathForRowAtPoint(locationInView)
            
            if state == UIGestureRecognizerState.Began{
                return schoolDataSource[pressedIndexPath!.row]
            }
        }
        return nil
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
        print(selectedSchool)
        self.navigationController?.pushViewController(selectedSchoolController, animated: true)
    }

    
}