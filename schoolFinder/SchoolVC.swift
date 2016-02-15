//
//  SchoolVC.swift
//  schoolFinder
//
//  Created by Jonathan Yu on 2/15/16.
//  Copyright © 2016 Jonathan Yu. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import Whisper

class SchoolViewController: UIViewController {
    var apiURL: String = "https://api.data.gov/ed/collegescorecard/v1/schools"
    var queriedParams: [String: String]
    
    //    Helpers
    var dataFields = DataFields()
    var messageHelper = MessageHelper()
    
    var selectedSchoolID: String
    
    init(schoolID: String) {
        selectedSchoolID = schoolID
        queriedParams = dataFields.print_all_properties_with_query(["id": schoolID])
        super.init(nibName: nil, bundle: nil)
        
        print(queriedParams)
        title = "School"
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(schoolID: "")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.flatWhiteColorDark()
        
        if selectedSchoolID == "0" {
            Whisper(messageHelper.schoolErrorMessage, to: self.navigationController!, action: .Present)
            Silent(self.navigationController!, after: 4.0)
        }
    }
    
}