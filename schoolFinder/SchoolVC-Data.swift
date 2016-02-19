//
//  SchoolVC-Data.swift
//  schoolFinder
//
//  Created by Jonathan Yu on 2/16/16.
//  Copyright © 2016 Jonathan Yu. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import Whisper
import RealmSwift

extension SchoolViewController {
    
    func prepareData(completion: (downloaded: Bool) -> Void) {
        Alamofire.request(.GET, apiURL, parameters: queriedParams).responseObject { (response: Response<DataResponse, NSError>) -> Void in
            if let successResponse = response.result.value {
                self.selectedSchool = successResponse.results!.first as Result!
                let mirroredSchool = Mirror(reflecting: self.selectedSchool)
                for (_, attr) in mirroredSchool.children.enumerate() {
                    if let label = attr.label as String! {
                        self.schoolPropertyKey.append(label)
                    }
                }
                completion(downloaded: true)
            } else {
                Whisper(self.messageHelper.errorMessage, to: self.navigationController!, action: .Present)
                Silent(self.navigationController!, after: 3.0)
                completion(downloaded: false)
            }
        }
    }
    
    func saveCollege() {
        let collegeToSave = SchoolViewModel()
        collegeToSave.SCHOOL_URL = selectedSchool.SCHOOL_URL
        collegeToSave.NAME = selectedSchool.NAME
        collegeToSave.CITY = selectedSchool.CITY
        collegeToSave.ID = selectedSchool.ID
        
        let realm = try! Realm()
        do {
            try! realm.write({ () -> Void in
                realm.add(collegeToSave)
                Whisper(self.messageHelper.schoolSavedMessage, to: self.navigationController!)
            })
        } catch let error as NSError {
            Whisper(self.messageHelper.errorMessage, to: self.navigationController!)
        }
    }
    
    func openShareMenu() {
        let textToShare = "Check out this school: \(selectedSchool?.NAME) :: College ID: \(selectedSchool?.ID)"
        let saveActivity = SaveCollegeActivity()
        let activityViewController = UIActivityViewController(activityItems: [textToShare], applicationActivities: [saveActivity])
        
        self.presentViewController(activityViewController, animated: true, completion: nil)
    }
    
    
    func openOptionsMenu(sender: AnyObject) {
        let actionsheet: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)

        let saveAction = UIAlertAction(title: "Save College", style: .Default) { (action) -> Void in
            self.saveCollege()
        }

        let shareAction = UIAlertAction(title: "Share College", style: .Default) { (action) -> Void in
            self.openShareMenu()
        }
        
//        Cancel the action sheet
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) -> Void in
            actionsheet.dismissViewControllerAnimated(true, completion: nil)
        }
        
        actionsheet.addAction(saveAction)
        actionsheet.addAction(shareAction)
        actionsheet.addAction(cancelAction)
        presentViewController(actionsheet, animated: true, completion: nil)
    }
    
}