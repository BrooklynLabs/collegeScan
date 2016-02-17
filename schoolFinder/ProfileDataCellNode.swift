//
//  ProfileDataCellNode.swift
//  schoolFinder
//
//  Created by Jonathan Yu on 2/17/16.
//  Copyright © 2016 Jonathan Yu. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class ProfileDataCellNode: ASCellNode {
    
    var labelNode: ASTextNode
    var valueNode: ASTextNode
//    var collapse: ASTextNode
    
    init!(label: String, value: String) {
        labelNode = ASTextNode()
        valueNode = ASTextNode()
        
        super.init()
        setupProfileNode(label, value: value)
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let horizontalSpec = ASStackLayoutSpec(direction: ASStackLayoutDirection.Horizontal, spacing: 8.0, justifyContent: ASStackLayoutJustifyContent.SpaceBetween, alignItems: ASStackLayoutAlignItems.BaselineFirst, children: [labelNode, valueNode])
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 5.0, left: 10.0, bottom: 5.0, right: 10.0), child: horizontalSpec)
    }
    
    func setupProfileNode(label: String, value: String) {
        labelNode.attributedString = NSAttributedString(string: label, attributes: [
            NSFontAttributeName: UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
            ])
        labelNode.placeholderColor = UIColor.blackColor()
        
        valueNode.attributedString = NSAttributedString(string: value, attributes: [
            NSFontAttributeName: UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
            ])
        valueNode.placeholderColor = UIColor.blackColor()
        
        addSubnode(labelNode)
        addSubnode(valueNode)
    }
    
}