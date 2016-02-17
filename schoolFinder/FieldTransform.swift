//
//  FieldTransform.swift
//  schoolFinder
//
//  Created by Jonathan Yu on 2/17/16.
//  Copyright © 2016 Jonathan Yu. All rights reserved.
//

import Foundation
import ObjectMapper

public class FieldTransform: TransformType {
    public typealias Object = String
    public typealias JSON = String
    
    public init() {}
    
    public func transformFromJSON(value: AnyObject?) -> String? {
        if let valueInt = value as? Int {
            return String(valueInt)
        }
        
        if let valueDouble = value as? Double {
            return String(valueDouble)
        }
        
        return "Not Found"
    }
    
    public func transformToJSON(value: String?) -> String? {
        return nil
    }
    
}