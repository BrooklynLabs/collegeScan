//
//  MapVC.swift
//  schoolFinder
//
//  Created by Jonathan Yu on 2/8/16.
//  Copyright © 2016 Jonathan Yu. All rights reserved.
//

import Foundation
import AsyncDisplayKit
import BTNavigationDropdownMenu

class BrowseController: UIViewController, ASTableDataSource, ASTableDelegate {
    var tableView: ASTableView!
    let browseOptions = ["States": "stateSettings", "Carnegie Basic": "carnegieBasicSettings", "Locale": "localeSettings", "Carnegie Size": "carnegieSizeSettings"]
    let browseFieldKeys = ["stateSettings": "school.state", "carnegieBasicSettings": "school.carnegie_basic", "localeSettings": "school.locale", "carnegieSizeSettings": "school.carnegie_size_setting"]
    
    var optionsDict = [String: String]()
    let optionsReference = OptionSettings()
    let dataFields = DataFields()
    var selectedFieldKey: String!
    
    var menuView: BTNavigationDropdownMenu!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Browse Schools"
        menuView = BTNavigationDropdownMenu(navigationController: self.navigationController!, title: "Select Browse Options", items: Array(browseOptions.keys))
        tableView = ASTableView(frame: view.bounds)
        tableView.asyncDataSource = self
        tableView.asyncDelegate = self
        view.addSubview(tableView)
        
        setupMenu()
    }
    
    func setupMenu() {
        self.navigationItem.titleView = menuView
        menuView.cellBackgroundColor = UIColor.flatPurpleColor()
        menuView.cellTextLabelColor = UIColor.whiteColor()
        
        menuView.didSelectItemAtIndexHandler = { (indexPath: Int) -> Void in
//            Handle the switchover by assigning three variables: the option names, selected API query param key and api query param value
            let selectedSelectionOption = Array(self.browseOptions.values)[indexPath]
            self.optionsDict = self.optionsReference.valueForKey(selectedSelectionOption) as! [String: String]
            self.selectedFieldKey = self.browseFieldKeys[selectedSelectionOption]
            
            self.tableView.reloadData()
        }
    }
    
    func tableView(tableView: ASTableView, nodeForRowAtIndexPath indexPath: NSIndexPath) -> ASCellNode {
        let cellNode = JYTextCellNode(text: Array(optionsDict.keys)[indexPath.row])
        
        return cellNode
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        Grab the api specific key code for the selected browse field
        let queriedValue: String = Array(optionsDict.values)[indexPath.row]
        let queriedParam = [selectedFieldKey: queriedValue]
        
//        Init a queryVC
        let queryVCtoPush = QueryViewController(params: queriedParam)
        
        self.navigationController!.pushViewController(queryVCtoPush, animated: true)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return optionsDict.count
    }
    
}