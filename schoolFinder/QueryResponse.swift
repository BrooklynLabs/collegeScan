//
//  QueryResponse.swift
//  schoolFinder
//
//  Created by Jonathan Yu on 2/16/16.
//  Copyright © 2016 Jonathan Yu. All rights reserved.
//

import Foundation
import ObjectMapper

class QueryResponse: Mappable {
    var results: [QueryResult]?
    
    var errors: [Error]?
    
    var metadataTotal: Int?
    var metadataPage: Int?
    var metadataPerPage: Int?
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        //        Error mappings
        errors <- map["errors"]
        results <- map["results"]
        //        Meta Data mapping
        metadataTotal <- map["metadata.total"]
        metadataPage <- map["metadata.page"]
        metadataPerPage <- map["metadata.per_page"]
    }
    
}