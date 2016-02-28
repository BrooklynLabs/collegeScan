//
//  CompareSchoolCell.swift
//  schoolFinder
//
//  Created by Jonathan Yu on 2/26/16.
//  Copyright © 2016 Jonathan Yu. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class CompareSchoolCell: ASCellNode {
    
    var labelNode: ASTextNode
    var firstValueNode: ASTextNode
    var secondValueNode: ASTextNode
    
    init!(label: String, value1: String, value2: String) {
        labelNode = ASTextNode()
        firstValueNode = ASTextNode()
        secondValueNode = ASTextNode()
        
        super.init()
        setupProfileNode(label, value1: value1, value2: value2)
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let compareHorizontalSpec = ASStackLayoutSpec(direction: ASStackLayoutDirection.Horizontal, spacing: 8.0, justifyContent: ASStackLayoutJustifyContent.SpaceBetween, alignItems: ASStackLayoutAlignItems.BaselineFirst, children: [firstValueNode, secondValueNode])
        
        let verticalSpec = ASStackLayoutSpec(direction: ASStackLayoutDirection.Vertical, spacing: 8.0, justifyContent: ASStackLayoutJustifyContent.SpaceBetween, alignItems: ASStackLayoutAlignItems.BaselineFirst, children: [compareHorizontalSpec, labelNode])
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 5.0, left: 10.0, bottom: 5.0, right: 10.0), child: verticalSpec)
    }
    
    func setupProfileNode(label: String, value1: String, value2: String) {
        labelNode.attributedString = NSAttributedString(string: label, attributes: [
            NSFontAttributeName: UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline),
            NSUnderlineStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue
            ])
        labelNode.placeholderColor = UIColor.blackColor()
        
        firstValueNode.attributedString = NSAttributedString(string: value1, attributes: [
            NSFontAttributeName: UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
            ])
        firstValueNode.placeholderColor = UIColor.blackColor()
        
        secondValueNode.attributedString = NSAttributedString(string: value2, attributes: [
            NSFontAttributeName: UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
            ])
        secondValueNode.placeholderColor = UIColor.blackColor()

        
        addSubnode(labelNode)
        addSubnode(firstValueNode)
        addSubnode(secondValueNode)
    }
    
}