//
//  SearchVC.swift
//  schoolFinder
//
//  Created by Jonathan Yu on 2/12/16.
//  Copyright © 2016 Jonathan Yu. All rights reserved.
//

import Foundation
import UIKit
import AsyncDisplayKit

class SearchViewController: UIViewController, ASTableViewDataSource, ASTableViewDelegate {
    var tableView: ASTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = ASTableView(frame: view.bounds)
        tableView.asyncDataSource = self
        tableView.asyncDelegate = self
        view.addSubview(tableView)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Search", style: UIBarButtonItemStyle.Plain, target: self, action: "openSearchMenu:")
    }
    
    func tableView(tableView: ASTableView, nodeForRowAtIndexPath indexPath: NSIndexPath) -> ASCellNode {
        return ASCellNode()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func openSearchMenu(sender: AnyObject) {
        let searchSubVC = SearchMenuViewController()
        
        navigationController?.pushViewController(searchSubVC, animated: true)
    }
}