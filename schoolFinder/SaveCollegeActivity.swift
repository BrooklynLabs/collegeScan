//
//  CustomSaveActivity.swift
//  schoolFinder
//
//  Created by Jonathan Yu on 2/19/16.
//  Copyright © 2016 Jonathan Yu. All rights reserved.
//

import UIKit

class SaveCollegeActivity: UIActivity {
    
    override func activityImage() -> UIImage? {
        return UIImage(named: "Save")
    }
    
    override func activityTitle() -> String? {
        return "Save College"
    }
    
    override func canPerformWithActivityItems(activityItems: [AnyObject]) -> Bool {
        for activityItem in activityItems {
            if activityItem.isKindOfClass(Result) {
                print("Found it")
            }
        }
        return false
    }
    
}