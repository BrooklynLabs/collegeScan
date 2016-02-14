//
//  QueryVC.swift
//  schoolFinder
//
//  Created by Jonathan Yu on 2/12/16.
//  Copyright © 2016 Jonathan Yu. All rights reserved.
//

import Foundation
import AsyncDisplayKit
import Alamofire
import AlamofireObjectMapper
import Whisper

class QueryViewController: UIViewController, ASTableViewDataSource, ASTableViewDelegate {
    var apiURL: String = "https://api.data.gov/ed/collegescorecard/v1/schools"
    var tableView: ASTableView!
    var dataFields = DataFields()
    var messageHelper = MessageHelper()
    var queriedParams: [String: String]
    
    init(params: [String: String]) {
        queriedParams = dataFields.print_minimum_properties_with_query(params)
        super.init(nibName: nil, bundle: nil)
        
        title = Array(params.values).first
        prepareData()
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(params: ["":""])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = ASTableView(frame: view.bounds)
        tableView.asyncDataSource = self
        tableView.asyncDelegate = self
        view.addSubview(tableView)
    }
    
    func prepareData() {
        Alamofire.request(.GET, apiURL, parameters: queriedParams).responseObject { (response: Response<DataResponse, NSError>) -> Void in
            if let successResponse = response.result.value {
                print(successResponse)
            } else {
                print(response)
                print(response.result.error)
            }
        }
    }
    
    func tableView(tableView: ASTableView, nodeForRowAtIndexPath indexPath: NSIndexPath) -> ASCellNode {
        return ASCellNode()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
}