//
//  DataManager.swift
//  schoolFinder
//
//  Created by Jonathan Yu on 2/8/16.
//  Copyright © 2016 Jonathan Yu. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import Async

class DataManagerVC: UIViewController {
    var progressTracker: UIProgressView!
    var startButton: UIButton!
    
    var stackView: UIStackView!
    
    var xCenterConstraint: NSLayoutConstraint?
    var yCenterConstraint: NSLayoutConstraint?    
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        progressTracker = UIProgressView()
        progressTracker.heightAnchor.constraintEqualToConstant(50).active = true
        progressTracker.widthAnchor.constraintEqualToConstant(200).active = true
        
        startButton = UIButton(type: UIButtonType.RoundedRect)
        startButton.backgroundColor = UIColor.flatGreenColorDark()
        startButton.setTitle("Download", forState: UIControlState.Normal)
        startButton.addTarget(self, action: "download", forControlEvents: UIControlEvents.TouchUpInside)
        startButton.heightAnchor.constraintEqualToConstant(75).active = true
        startButton.widthAnchor.constraintEqualToConstant(200).active = true
        
        stackView = UIStackView()
        stackView.axis = UILayoutConstraintAxis.Vertical
        stackView.distribution = .EqualSpacing
        stackView.alignment = .Center
        stackView.spacing = 30
        
        stackView.addArrangedSubview(startButton)
        stackView.addArrangedSubview(progressTracker)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        stackView.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        stackView.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor).active = true
    }
    
    func download() {
        
    }
}