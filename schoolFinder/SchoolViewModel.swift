//
//  SchoolViewModel.swift
//  schoolFinder
//
//  Created by Jonathan Yu on 2/14/16.
//  Copyright © 2016 Jonathan Yu. All rights reserved.
//

import Foundation

class SchoolViewModel: NSObject {
    
    var NAME: String
    var SCHOOL_URL: String
    var ID: String
    var CITY: String
    
    init(school: QueryResult) {
        NAME = "Unknown"
        SCHOOL_URL = "Unknown URL"
        ID = "0"
        CITY = "unknown City"
        super.init()
        
        setupWithResult(school)
    }
    
    init(name: String, school_url: String, id: String, city: String) {
        self.NAME = name
        self.SCHOOL_URL = school_url
        self.ID = id
        self.CITY = city
    }
    
//    required convenience init?(coder aDecoder: NSCoder) {
//        guard let NAME = aDecoder.decodeObjectForKey("NAME") as? String,
//            let SCHOOL_URL = aDecoder.decodeObjectForKey("SCHOOL_URL") as? String,
//            let ID = aDecoder.decodeObjectForKey("ID") as? String,
//            let CITY = aDecoder.decodeObjectForKey("CITY") as? String
//            else {
//                return nil
//        }
//        
//        self.init(
//        
//    }
    
    class func createViewModels(schools: [QueryResult]) -> [SchoolViewModel] {
        var viewmodels = [SchoolViewModel]()
        for school in schools {
            viewmodels.append(SchoolViewModel(school: school))
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