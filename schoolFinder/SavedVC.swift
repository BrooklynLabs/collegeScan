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

class SavedViewController: SchoolTableViewController {
    var savedSchools: Results<SchoolViewModel>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Saved Schools"
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        savedSchools = try! Realm().objects(SchoolViewModel)
        if savedSchools.count == 0 {
            Whisper(messageHelper.emptyMessage, to: self.navigationController!, action: .Present)
            Silent(self.navigationController!, after: 3.0)
        } else {
            schoolDataSource = savedSchools.map({ $0 })
            tableView.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let deleteClosure = {(action: UITableViewRowAction!, indexPath: NSIndexPath) -> Void in
            let schoolToDelete = self.savedSchools[indexPath.row]
            do {
                let realm = try! Realm()
                try realm.write({ () -> Void in
                    realm.delete(schoolToDelete)
                    self.schoolDataSource.removeAtIndex(indexPath.row)
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