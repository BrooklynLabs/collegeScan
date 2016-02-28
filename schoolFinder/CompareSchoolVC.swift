//
//  CompareSchoolVC.swift
//  schoolFinder
//
//  Created by Jonathan Yu on 2/26/16.
//  Copyright © 2016 Jonathan Yu. All rights reserved.
//

import Foundation
import Whisper
import AsyncDisplayKit
import RealmSwift
import Alamofire

class CompareSchoolViewController: UIViewController, ASTableDataSource, ASTableDelegate {
    var apiURL: String = "https://api.data.gov/ed/collegescorecard/v1/schools"
    //    Helpers
    var dataFields = DataFields()
    var messageHelper = MessageHelper()

    var queriedParams: [String: String] = [String: String]()
    
    var firstSchoolID: String
    var secondSchoolID: String
    var firstSchool: Result!
    var secondSchool: Result!
    
    var schoolTable: ASTableView!
    var schoolPropertyKey: [String] = []
    
    var connectedToInternet: Bool = NetConnectedNess.isConnectedToNetwork()
    
    init(schoolID1: String, schoolID2: String) {
        firstSchoolID = schoolID1
        secondSchoolID = schoolID2
        super.init(nibName: nil, bundle: nil)
        
        title = "School"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Options", style: UIBarButtonItemStyle.Plain, target: self, action: "openOptionsMenu:")
        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(schoolID1: "", schoolID2: "")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.flatWhiteColorDark()
        prepareTable()
        prepareQueryString()
//        Check for no internet
        if NetConnectedNess.isConnectedToNetwork() {
            Whisper(messageHelper.downloadingMessage, to: self.navigationController!, action: .Present)
            prepareData({ (downloaded) -> Void in
                self.schoolTable.reloadData()
                Silent(self.navigationController!)
            })
        } else {
//            If wifi is off, run an error msg
            Whisper(messageHelper.noInternetMessage, to: self.navigationController!, action: .Present)
            Silent(self.navigationController!, after: 3.0)
        }
    }
    
    func prepareQueryString() {
        queriedParams = dataFields.print_all_properties_for_query()
        if firstSchoolID == "0" || secondSchoolID == "0" {
            Whisper(messageHelper.schoolErrorMessage, to: self.navigationController!, action: .Present)
            Silent(self.navigationController!, after: 4.0)
        }
        queriedParams["id"] = "\(firstSchoolID),\(secondSchoolID)"
    }
    
    func prepareData(completion: (downloaded: Bool) -> Void) {
        Alamofire.request(.GET, apiURL, parameters: queriedParams).responseObject { (response: Response<DataResponse, NSError>) -> Void in
            if let successResponse = response.result.value {
                self.firstSchool = successResponse.results!.first as Result!
                self.secondSchool  = successResponse.results![1] as Result!
                
                let mirroredFirstSchool = Mirror(reflecting: self.firstSchool)
                
                for (_, attr) in mirroredFirstSchool.children.enumerate() {
                    if let label = attr.label as String! {
                        self.schoolPropertyKey.append(label)
                    }
                }
                completion(downloaded: true)
            } else {
                Whisper(self.messageHelper.errorMessage, to: self.navigationController!, action: .Present)
                Silent(self.navigationController!, after: 3.0)
                completion(downloaded: false)
            }
        }
    }
    
    func prepareTable() {
        schoolTable = ASTableView(frame: view.bounds, style: UITableViewStyle.Plain, asyncDataFetching: true)
        schoolTable.asyncDataSource = self
        schoolTable.asyncDelegate = self
        view.addSubview(schoolTable)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schoolPropertyKey.count
    }
    
    func tableView(tableView: ASTableView, nodeForRowAtIndexPath indexPath: NSIndexPath) -> ASCellNode {
        let labelValue = schoolPropertyKey[indexPath.row] as String!
        let value1Value = firstSchool.print_value(labelValue)
        let value2Value = secondSchool.print_value(labelValue)
        let cell = CompareSchoolCell(label: labelValue, value1: value1Value, value2: value2Value)
        
        return cell
    }
    
    
}