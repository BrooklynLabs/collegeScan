//
//  SchoolViewModel.swift
//  schoolFinder
//
//  Created by Jonathan Yu on 2/14/16.
//  Copyright © 2016 Jonathan Yu. All rights reserved.
//

import Foundation
import RealmSwift

class SchoolViewModel: Object {
    
    dynamic var NAME: String = "Unknown"
    dynamic var SCHOOL_URL: String = "Unknown URL"
    dynamic var ID: String = "0"
    dynamic var CITY: String = "unknown City"
    
    class func createViewModels(queryResults: [QueryResult]) -> [SchoolViewModel] {
        var viewmodels = [SchoolViewModel]()
        for queryResult in queryResults {
            let schoolVM = SchoolViewModel()
            schoolVM.setupWithResult(queryResult)
            viewmodels.append(schoolVM)
        }
        
        return viewmodels
    }
    
    func setupWithResult(school: QueryResult) {
        if school.NAME != nil {
            NAME = school.NAME!
        }
        
        if school.SCHOOL_URL != nil {
            SCHOOL_URL = school.SCHOOL_URL!
        }
        
        if school.CITY != nil {
            CITY = school.CITY!
        }
        
        if school.ID != nil {
            ID = String(school.ID!)
        }
    }
    
}