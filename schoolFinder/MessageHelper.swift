//
//  MessageHelper.swift
//  schoolFinder
//
//  Created by Jonathan Yu on 2/13/16.
//  Copyright © 2016 Jonathan Yu. All rights reserved.
//

import Foundation
import Whisper
import ChameleonFramework

struct MessageHelper {
    
    let downloadingMessage = Message(title: "Downloading ...", textColor: UIColor.whiteColor(), backgroundColor: UIColor.flatYellowColorDark(), images: nil)
    
    let emptyMessage = Message(title: "Nothing to Show", textColor: UIColor.whiteColor(), backgroundColor: UIColor.flatRedColor(), images: nil)
    let emptyQuery = Message(title: "Nothing to Search", textColor: UIColor.whiteColor(), backgroundColor: UIColor.flatRedColor(), images: nil)

    
//    Error messages
    let schoolErrorMessage = Message(title: "School Not Found :(", textColor: UIColor.whiteColor(), backgroundColor: UIColor.flatRedColor(), images: nil)
    let errorMessage = Message(title: "Something is Wrong :(", textColor: UIColor.whiteColor(), backgroundColor: UIColor.flatRedColor(), images: nil)
    
    let schoolSavedMessage = Message(title: "Save Successful!", textColor: UIColor.whiteColor(), backgroundColor: UIColor.flatGreenColorDark(), images: nil)
    
    let noInternetMessage = Message(title: "No Connection Detected", textColor: UIColor.whiteColor(), backgroundColor: UIColor.flatGrayColorDark(), images: nil)
}
