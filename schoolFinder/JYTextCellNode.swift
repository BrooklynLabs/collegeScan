//
//  JYTextCellNode.swift
//  schoolFinder
//
//  Created by Jonathan Yu on 2/17/16.
//  Copyright © 2016 Jonathan Yu. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class JYTextCellNode: ASCellNode {
    
    var titleNode: ASTextNode
    //    var collapse: ASTextNode
    
    init!(text: String) {
        titleNode = ASTextNode()
        
        super.init()
        setupProfileNode(text)
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 5.0, left: 10.0, bottom: 5.0, right: 10.0), child: titleNode)
    }
    
    func setupProfileNode(label: String) {
        titleNode.attributedString = NSAttributedString(string: label, attributes: [
            NSFontAttributeName: UIFont.preferredFontForTextStyle(UIFontTextStyleTitle3)
            ])
        titleNode.placeholderColor = UIColor.blackColor()
        
        addSubnode(titleNode)
    }
    
}