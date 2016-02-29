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
    var firstSchool: QueryResult!
    var secondSchool: QueryResult!
    
    var schoolTable: ASTableView!
    var schoolPropertyKey: [String] = []
    var headerTableHeight: CGFloat = 55.0
    
    var connectedToInternet: Bool = NetConnectedNess.isConnectedToNetwork()
    
    init(schoolID1: String, schoolID2: String) {
        firstSchoolID = schoolID1
        secondSchoolID = schoolID2
        super.init(nibName: nil, bundle: nil)
        
        title = "Comparison"
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
                self.reloadTableHeader()
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
        Alamofire.request(.GET, apiURL, parameters: queriedParams).responseObject { (response: Response<QueryResponse, NSError>) -> Void in
            if let successResponse = response.result.value {
                self.firstSchool = successResponse.results!.first as QueryResult!
                self.secondSchool  = successResponse.results![1] as QueryResult!
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
        schoolTable.separatorColor = UIColor.flatPurpleColor()
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        schoolTable.deselectRowAtIndexPath(indexPath, animated: true)
        let selectedKey = schoolPropertyKey[indexPath.row] as String!
        let value1Value = firstSchool.print_value(selectedKey)
        let value2Value = secondSchool.print_value(selectedKey)
        
        let postedMessage = "\(firstSchool.print_value("NAME")): \(value1Value) \n\n \(secondSchool.print_value("NAME")): \(value2Value)"
        
        let alertController = UIAlertController(title: selectedKey, message: postedMessage, preferredStyle: UIAlertControllerStyle.Alert)
        let alertDismiss = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Destructive, handler: nil)
        alertController.addAction(alertDismiss)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: headerTableHeight))
        let schoolHeader1 = UILabel(frame: CGRect(x: 0, y: 0, width: view.bounds.width/2, height: headerTableHeight))
        let schoolHeader2 = UILabel(frame: CGRect(x: schoolHeader1.frame.maxX, y: 0, width: view.bounds.width/2, height: headerTableHeight))
        
        schoolHeader1.text = "First School"
        schoolHeader2.text = "Second School"
        schoolHeader1.textAlignment = .Center
        schoolHeader2.textAlignment = .Center
        schoolHeader1.lineBreakMode = .ByWordWrapping
        schoolHeader2.lineBreakMode = .ByWordWrapping
        schoolHeader1.textColor = UIColor.whiteColor()
        schoolHeader2.textColor = UIColor.whiteColor()
        
        headerView.addSubview(schoolHeader1)
        headerView.addSubview(schoolHeader2)
        headerView.backgroundColor = UIColor.flatPurpleColor()
        
        return headerView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerTableHeight
    }
    
    func reloadTableHeader() {
        if firstSchool != nil && secondSchool != nil {
            let headerView = schoolTable.headerViewForSection(0)
            let schoolHeader1 = headerView?.subviews.first as? UILabel
            let schoolHeader2 = headerView?.subviews[1] as? UILabel
            
            schoolHeader1?.text = firstSchool.print_value("name")
            schoolHeader2?.text = secondSchool.print_value("name")
        }
    }
    
}