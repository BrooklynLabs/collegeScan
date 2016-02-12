//
//  Error.swift
//  schoolFinder
//
//  Created by Jonathan Yu on 2/11/16.
//  Copyright © 2016 Jonathan Yu. All rights reserved.
//

import Foundation
import ObjectMapper

class Error: Mappable {
    var error: String?
    var error_input: String?
    var message: String?
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        error <- map["error"]
        error_input <- map["input"]
        message <- map["message"]
    }

}