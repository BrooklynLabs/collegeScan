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
import RealmSwift

class SavedViewController: UIViewController, ASTableDataSource, ASTableDelegate {
    var tableView: ASTableView!
    var savedSchools: Results<SchoolViewModel>!
    var messageHelper = MessageHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Saved Schools"
        tableView = ASTableView(frame: view.frame)
        tableView.asyncDataSource = self
        tableView.asyncDelegate = self
        view.addSubview(tableView)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        savedSchools = try! Realm().objects(SchoolViewModel)
        if savedSchools.count == 0 {
            Whisper(messageHelper.emptyMessage, to: self.navigationController!, action: .Present)
        } else {
            tableView.reloadData()
        }
    }
    
    func tableView(tableView: ASTableView, nodeForRowAtIndexPath indexPath: NSIndexPath) -> ASCellNode {
        if let schoolAtIndexPath = savedSchools?[indexPath.row] {
            return SchoolNode(result: schoolAtIndexPath)
        } else {
            return ASCellNode()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard savedSchools?.count != nil else {
            return 0
        }
        
        return savedSchools!.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let selectedSchool = savedSchools[indexPath.row]
        let selectedSchoolController = SchoolViewController(schoolID: selectedSchool.ID)
        
        self.navigationController?.pushViewController(selectedSchoolController, animated: true)
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let deleteClosure = {(action: UITableViewRowAction!, indexPath: NSIndexPath) -> Void in
            let schoolToDelete = self.savedSchools[indexPath.row]
            do {
                let realm = try! Realm()
                try realm.write({ () -> Void in
                    realm.delete(schoolToDelete)
                })
                tableView.reloadData()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Destructive, title: "Delete", handler: deleteClosure)
        
        return [deleteAction]
    }

    
}