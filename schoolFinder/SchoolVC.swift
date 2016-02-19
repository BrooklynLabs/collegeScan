//
//  SchoolVC.swift
//  schoolFinder
//
//  Created by Jonathan Yu on 2/15/16.
//  Copyright © 2016 Jonathan Yu. All rights reserved.
//

import Foundation
import Whisper
import AsyncDisplayKit
import RealmSwift

class SchoolViewController: UIViewController {
    var apiURL: String = "https://api.data.gov/ed/collegescorecard/v1/schools"
    var queriedParams: [String: String]
    
    //    Helpers
    var dataFields = DataFields()
    var messageHelper = MessageHelper()
    
    var selectedSchoolID: String
    var selectedSchool: Result!
    
    var schoolTable: ASTableView!
    var schoolPropertyKey: [String] = []
    var schoolPropertyValue: [String] = []
    
    init(schoolID: String) {
        selectedSchoolID = schoolID
        queriedParams = dataFields.print_id_query()
        queriedParams["id"] = schoolID
        super.init(nibName: nil, bundle: nil)
        
        title = "School"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Options", style: UIBarButtonItemStyle.Plain, target: self, action: "openOptionsMenu:")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(schoolID: "")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.flatWhiteColorDark()
        prepareTable()
        
        if selectedSchoolID == "0" {
            Whisper(messageHelper.schoolErrorMessage, to: self.navigationController!, action: .Present)
            Silent(self.navigationController!, after: 4.0)
        } else {
            Whisper(messageHelper.downloadingMessage, to: self.navigationController!, action: .Present)
            prepareData({ (downloaded) -> Void in
                self.schoolTable.reloadData()
                Silent(self.navigationController!)
            })
        }
    }
    
}