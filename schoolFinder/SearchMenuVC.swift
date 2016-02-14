//
//  SearchMenuVC.swift
//  schoolFinder
//
//  Created by Jonathan Yu on 2/12/16.
//  Copyright © 2016 Jonathan Yu. All rights reserved.
//

import Foundation
import UIKit
import Eureka

class SearchMenuViewController: FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        form +++ Section("Section")
            <<< TextRow("ID") {
                $0.title = "ID"
            }
                
            <<< ButtonRow("Done") {
                $0.title = "Done"
            }
                
            <<< ButtonRow("Dismiss") { (row: ButtonRow) in
                row.title = "Dismiss"
                print("hello")
            }
    }
    
}