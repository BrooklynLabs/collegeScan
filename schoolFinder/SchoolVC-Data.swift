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

extension SchoolViewController {
    
    func prepareData(completion: (downloaded: Bool) -> Void) {
        Alamofire.request(.GET, apiURL, parameters: queriedParams).responseObject { (response: Response<DataResponse, NSError>) -> Void in
            if let successResponse = response.result.value {
                self.selectedSchool = successResponse.results!.first as Result!
                let mirroredSchool = Mirror(reflecting: self.selectedSchool)
                for (_, attr) in mirroredSchool.children.enumerate() {
                    self.schoolPropertyKey.append(attr.label!)
                }
                completion(downloaded: true)
            } else {
                Whisper(self.messageHelper.errorMessage, to: self.navigationController!, action: .Present)
                Silent(self.navigationController!, after: 3.0)
                completion(downloaded: false)
            }
        }
    }
    
    func openOptionsMenu(sender: AnyObject) {
        let textToShare = "Check out this school: \(selectedSchool.NAME) :: \(selectedSchool.SCHOOL_URL)"
        let activityViewController = UIActivityViewController(activityItems: [textToShare], applicationActivities: nil)
        
        self.presentViewController(activityViewController, animated: true, completion: nil)
    }
    
}