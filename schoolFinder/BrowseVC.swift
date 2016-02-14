//
//  MapVC.swift
//  schoolFinder
//
//  Created by Jonathan Yu on 2/8/16.
//  Copyright © 2016 Jonathan Yu. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class BrowseController: UIViewController, ASTableDataSource, ASTableDelegate {
    var tableView: ASTableView!
    var statesDict: [String: String]!
    
    let stateReference = StatesStruct()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Browse Schools"
        tableView = ASTableView(frame: view.bounds)
        tableView.asyncDataSource = self
        tableView.asyncDelegate = self
        view.addSubview(tableView)
        
        statesDict = stateReference.stateAbbrev
    }
    
    func tableView(tableView: ASTableView, nodeForRowAtIndexPath indexPath: NSIndexPath) -> ASCellNode {
        let cellNode = ASTextCellNode()
        cellNode.text = Array(statesDict.keys)[indexPath.row]
        
        return cellNode
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let dataFields = DataFields()
//        Grab the api specific key code for the state selected 'school.state = 1'
        let stateKeyValue: String = Array(statesDict.values)[indexPath.row]
        let stateQueryDict = [dataFields.STATE: stateKeyValue]
        
//        Init a queryVC
        let queryVCtoPush = QueryViewController(params: stateQueryDict)
        
        self.navigationController!.pushViewController(queryVCtoPush, animated: true)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statesDict.count
    }
    
}