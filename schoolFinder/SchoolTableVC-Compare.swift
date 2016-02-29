//
//  SchoolTableVC-Compare.swift
//  schoolFinder
//
//  Created by Jonathan Yu on 2/26/16.
//  Copyright © 2016 Jonathan Yu. All rights reserved.
//

import UIKit

extension SchoolTableViewController {
    
    func setupLongPress() {
        let longPress = UILongPressGestureRecognizer(target: self, action: "collegeSelected:")
        tableView.addGestureRecognizer(longPress)
    }
    
    func collegeSelected(senderRecognizer: UILongPressGestureRecognizer) {
        if let longPressedSchool = returnLongPressedSchool(senderRecognizer) {
            if !firstSchoolFilled {
                schoolComparisonHelper["firstSchool"] = longPressedSchool
                firstSchoolFilled = !firstSchoolFilled
                setAddSchoolButton(0, school: longPressedSchool)
            } else {
                schoolComparisonHelper["secondSchool"] = longPressedSchool
                secondSchoolFilled = !secondSchoolFilled
                setAddSchoolButton(1, school: longPressedSchool)
                
                if firstSchoolFilled && secondSchoolFilled {
                    let submitButtonFrame = calculateButtonFrame(2)
                    let submitButton = SchoolCompareButton(frame: submitButtonFrame)
                    submitButton.setTitle("Compare", forState: UIControlState.Normal)
                    submitButton.addTarget(self, action: "submitSchools:", forControlEvents: UIControlEvents.TouchUpInside)
                    self.view.addSubview(submitButton)
                }
            }
        }
    }
    
    func calculateButtonFrame(buttonNumber: Int) -> CGRect {
        let buttonMargin: CGFloat = 15.0
        let frameWidth: CGFloat = (view.frame.width - 3.0 * buttonMargin) / 2.0
        let frameHeight: CGFloat = 75.0
        let maxY: CGFloat = view.frame.height - 2 * frameHeight
        var calculatedFrame: CGRect = CGRectZero
        
        switch buttonNumber {
        case 0:
            calculatedFrame = CGRect(x: buttonMargin, y: maxY, width: frameWidth, height: frameHeight).insetBy(dx: 5.0, dy: 5.0)
        case 1:
            calculatedFrame = CGRect(x: (frameWidth + buttonMargin * 2.0), y: maxY, width: frameWidth, height: frameHeight).insetBy(dx: 5.0, dy: 5.0)
        case 2:
            calculatedFrame = CGRect(x: (view.frame.width - frameWidth)/2.0, y: navigationController!.navigationBar.frame.height + buttonMargin * 2.0, width: frameWidth, height: 50.0).insetBy(dx: 5.0, dy: 5.0)
        default:
            break
        }
        
        return calculatedFrame
    }
    
    func setAddSchoolButton(buttonNumber: Int, school: SchoolViewModel) {
        let schoolButtonFrame = calculateButtonFrame(buttonNumber)
        let schoolButton = SchoolCompareButton(frame: schoolButtonFrame)
        schoolButton.setTitle(school.NAME, forState: UIControlState.Normal)
        schoolButton.tag = buttonNumber
        schoolButton.addTarget(self, action: "removeButton:", forControlEvents: UIControlEvents.TouchDragOutside)
        UIView.animateWithDuration(1.50, delay: 0.0, usingSpringWithDamping: 2.0, initialSpringVelocity: 2.0, options: [], animations: { () -> Void in
            self.view.addSubview(schoolButton)
            }) { (completed) -> Void in
        }
    }
    
    func removeButton(sender: AnyObject) {
        if let sender = sender as? UIButton {
            if sender.tag == 0 {
                firstSchoolFilled = false
            } else if sender.tag == 1 {
                secondSchoolFilled = false
            }
            
            UIView.animateWithDuration(5.0, delay: 0.5, usingSpringWithDamping: 2.0, initialSpringVelocity: 2.0, options: [], animations: { () -> Void in
                sender.alpha = 0
                sender.removeFromSuperview()
                }, completion: { (completed) -> Void in
                    
            })
        }
    }
    
    func submitSchools(sender: AnyObject) {
        if (schoolComparisonHelper["firstSchool"] != nil) && (schoolComparisonHelper["secondSchool"] != nil) {
            let firstSchool = schoolComparisonHelper["firstSchool"] as SchoolViewModel!
            let secondSchool = schoolComparisonHelper["secondSchool"] as SchoolViewModel!
            let compareSchoolVC = CompareSchoolViewController(schoolID1: firstSchool.ID , schoolID2: secondSchool.ID)
            self.navigationController?.pushViewController(compareSchoolVC, animated: true)
        }
        
    }
    
}