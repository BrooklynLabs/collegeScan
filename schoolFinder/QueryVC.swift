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
    var queriedParams: [String: String]
    
    var tableView: ASTableView!
    
//    Helpers
    var dataFields = DataFields()
    var messageHelper = MessageHelper()
    
//    For pagination 
    var results: [SchoolViewModel] = []
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
        tableView = ASTableView(frame: view.bounds)
        tableView.asyncDataSource = self
        tableView.asyncDelegate = self
        view.addSubview(tableView)
        
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
                self.results += SchoolViewModel.createViewModels(successResponse.results!)
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
    
    func tableView(tableView: ASTableView, nodeForRowAtIndexPath indexPath: NSIndexPath) -> ASCellNode {
        let resultAtIndexPath = results[indexPath.row]
        let schoolNode = SchoolNode(result: resultAtIndexPath)
        
        return schoolNode
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let selectedSchool = results[indexPath.row]
        let selectedSchoolController = SchoolViewController(schoolID: selectedSchool.ID)
        
        self.navigationController?.pushViewController(selectedSchoolController, animated: true)
    }
    
    func tableView(tableView: ASTableView, willBeginBatchFetchWithContext context: ASBatchContext) {
        let previousCount = results.count
        prepareData { (downloaded) -> Void in
            if downloaded {
                Whisper(self.messageHelper.downloadingMessage, to: self.navigationController!, action: .Present)
                Silent(self.navigationController!, after: 2.0)

                let insertRowRange = previousCount..<self.results.count
                let insertPathsRange = insertRowRange.map( {NSIndexPath(forRow: $0, inSection: 0)} )
                self.tableView.insertRowsAtIndexPaths(insertPathsRange, withRowAnimation: UITableViewRowAnimation.Fade)
            }
        }
    }
    
}