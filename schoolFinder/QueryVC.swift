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

class QueryViewController: SchoolTableViewController {
    var apiURL: String = "https://api.data.gov/ed/collegescorecard/v1/schools"
    var queriedParams: [String: String]
    
//    Helpers
    var dataFields = DataFields()
    
//    For pagination
    var paging: Int = 0
    
    init(params: [String: String]) {
        queriedParams = dataFields.print_minimum_properties_with_query(params)
        super.init(nibName: nil, bundle: nil)
        
        title = Array(params.keys).first
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(params: ["":""])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        In ViewdidLoad because this calls for a NavigationController call and it doesnt exist in INIT. Also check for internet
        if NetConnectedNess.isConnectedToNetwork() {
            Whisper(messageHelper.downloadingMessage, to: self.navigationController!, action: .Present)
            prepareData { (downloaded) -> Void in
                self.tableView.reloadData()
                Silent(self.navigationController!)
            }
        } else {
            Whisper(messageHelper.noInternetMessage, to: self.navigationController!, action: .Present)
            Silent(self.navigationController!, after: 3.0)
        }
    }
    
    func prepareData(completion: (downloaded: Bool) -> Void) {
        if paging > 0 {
            queriedParams["page"] = String(paging)
        }
        Alamofire.request(.GET, apiURL, parameters: queriedParams).responseObject { (response: Response<QueryResponse, NSError>) -> Void in
            if let successResponse = response.result.value {
                self.schoolDataSource += SchoolViewModel.createViewModels(successResponse.results!)
                self.paging += 1
                completion(downloaded: true)
            } else {
                Whisper(self.messageHelper.errorMessage, to: self.navigationController!, action: .Present)
                Silent(self.navigationController!, after: 3.0)
                print(response)
                print(response.result.error)
                completion(downloaded: false)
            }
        }
    }
    
    func tableView(tableView: ASTableView, willBeginBatchFetchWithContext context: ASBatchContext) {
        let previousCount = schoolDataSource.count
        prepareData { (downloaded) -> Void in
            if downloaded {
                Whisper(self.messageHelper.downloadingMessage, to: self.navigationController!, action: .Present)
                Silent(self.navigationController!, after: 2.0)

                let insertRowRange = previousCount..<self.schoolDataSource.count
                let insertPathsRange = insertRowRange.map( {NSIndexPath(forRow: $0, inSection: 0)} )
                self.tableView.insertRowsAtIndexPaths(insertPathsRange, withRowAnimation: UITableViewRowAnimation.Fade)
            }
        }
    }
    
}