//
//  Item.swift
//  schoolFinder
//
//  Created by Jonathan Yu on 2/8/16.
//  Copyright © 2016 Jonathan Yu. All rights reserved.
//

import Foundation
import ObjectMapper

class Response: Mappable {
    var results: [Result]?
    
    var errors: [Error]?
    
    var metadataTotal: Int?
    var metadataPage: Int?
    var metadataPerPage: Int?
    
    required init?(_ map: Map) {
        
    }

    func mapping(map: Map) {
//        Error mappings
        errors <- map["errors"]
        
//        Meta Data mapping
        metadataTotal <- map["metadata.total"]
        metadataPage <- map["metadata.page"]
        metadataPerPage <- map["metadata.per_page"]
    }
    
}