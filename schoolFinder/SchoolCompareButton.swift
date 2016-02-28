//
//  SchoolCompareButton.swift
//  schoolFinder
//
//  Created by Jonathan Yu on 2/26/16.
//  Copyright © 2016 Jonathan Yu. All rights reserved.
//

import Foundation
import UIKit
import ChameleonFramework

class SchoolCompareButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.flatPurpleColor()
        setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        layer.cornerRadius = 5.0
        
        titleLabel?.textAlignment = .Center
        titleEdgeInsets = UIEdgeInsetsMake(3.0, 3.0, 3.0, 3.0)
        titleLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        clipsToBounds = true
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}