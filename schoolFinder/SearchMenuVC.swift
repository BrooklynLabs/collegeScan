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
import Whisper

class SearchMenuViewController: FormViewController {
    var info = "InformationSearchMenu"
    var delegate: SearchPassbackProtocol? = nil
    let messages = MessageHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupForm()
        title = "Search"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Search", style: UIBarButtonItemStyle.Plain, target: self, action: "search:")
    }
    
    override func viewWillDisappear(animated: Bool) {
        delegate?.receiveSearchParameters("hello")
    }
    
    func setupForm() {
        form +++ Section("School Location")
            
            <<< TextRow("school.name") {
                $0.title = "Name of College"
            }
            <<< TextRow("id") {
                $0.title = "ID"
                $0.placeholderColor = UIColor.flatYellowColorDark()
            }
            
            <<< TextRow("school.city") {
                $0.title = "City"
            }
            <<< ZipCodeRow("zip") {
                $0.title = "Desired School Zip Code"
                $0.onChange({ (row) -> () in
                    self.form.rowByTag("distance")?.hidden = false
                })
            }
            <<< IntRow("distance") {
                $0.tag = "distance"
                $0.title = "Distance from Zip Code"
                $0.hidden = Condition.Function(["zip"], { (form) -> Bool in
                    if let distanceRow: IntRow = form.rowByTag("zip") {
                        if distanceRow.value != nil {
                            return false
                        }
                    }
                    return true
                })
            }
            
        form +++ Section("ACT Test Scoring")
            <<< IntRow("2013.admissions.act_scores.25th_percentile.cumulative") {
                $0.title = "2013 25th Percentile ACT"
                $0.onChange({ (introw) -> () in
                    if introw.value > 36 {
                        introw.cell.textField.textColor = UIColor.redColor()
                    }
                })
            }
            <<< IntRow("2013.admissions.act_scores.midpoint.cumulative") {
                $0.title = "2013 50th Percentile ACT"
                $0.onChange({ (introw) -> () in
                    if introw.value > 36 {
                        introw.cell.textField.textColor = UIColor.redColor()
                    }
                })
            }
            <<< IntRow("2013.admissions.act_scores.75th_percentile.cumulative") {
                $0.title = "2013 75th Percentile ACT"
                $0.onChange({ (introw) -> () in
                    if introw.value > 36 {
                        introw.cell.textField.textColor = UIColor.redColor()
                    }
                })
            }
        
        form +++ Section("SAT Test Scoring")
            
            <<< IntRow("2013.admissions.sat_scores.average.overall") {
                $0.title = "2013 Average SAT Overall"
                $0.onChange({ (introw) -> () in
                    if introw.value > 2400 {
                        introw.cell.textField.textColor = UIColor.redColor()
                    }
                })
            }
            <<< IntRow("2013.admissions.sat_scores.midpoint.critical_reading") {
                $0.title = "2013 Average Critical Reading"
                $0.onChange({ (introw) -> () in
                    if introw.value > 800 {
                        introw.cell.textField.textColor = UIColor.redColor()
                    }
                })
            }
            <<< IntRow("2013.admissions.sat_scores.midpoint.math") {
                $0.title = "2013 Average Math"
                $0.onChange({ (introw) -> () in
                    if introw.value > 800 {
                        introw.cell.textField.textColor = UIColor.redColor()
                    }
                })
            }
            <<< IntRow("2013.admissions.sat_scores.midpoint.writing") {
                $0.title = "2013 Average Writing"
                $0.onChange({ (introw) -> () in
                    if introw.value > 800 {
                        introw.cell.textField.textColor = UIColor.redColor()
                    }
                })
            }

        
    }
    
    func search(sender: AnyObject) {
        var query = [String: String]()
        for (title, value) in form.values() {
            if value != nil {
                if let value = value as? Int {
                    query[title] = String(value)
                }
                
                if let value = value as? String {
                    query[title] = value
                }
            }
        }
        
        if Array(query.keys).isEmpty {
            Whisper(messages.emptyQuery, to: self.navigationController!, action: .Present)
            Silent(self.navigationController!, after: 5.0)
        } else {
            let queryVCtoPush = QueryViewController(params: query)
            
            self.navigationController!.pushViewController(queryVCtoPush, animated: true)
        }
    }
    
}