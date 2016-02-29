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
        
        let horizontalStackSpec1 = ASStackLayoutSpec(direction: ASStackLayoutDirection.Vertical, spacing: 0.0, justifyContent: ASStackLayoutJustifyContent.Center, alignItems: ASStackLayoutAlignItems.Center, children: [firstValueNode])
        horizontalStackSpec1.flexGrow = true

        let horizontalStackSpec2 = ASStackLayoutSpec(direction: ASStackLayoutDirection.Vertical, spacing: 0.0, justifyContent: ASStackLayoutJustifyContent.Center, alignItems: ASStackLayoutAlignItems.Center, children: [secondValueNode])
        horizontalStackSpec2.flexGrow = true
        
        let compareHorizontalSpec = ASStackLayoutSpec(direction: ASStackLayoutDirection.Horizontal, spacing: 8.0, justifyContent: ASStackLayoutJustifyContent.SpaceAround, alignItems: ASStackLayoutAlignItems.Center, children: [horizontalStackSpec1, horizontalStackSpec2])
        compareHorizontalSpec.flexGrow = true
        
        let labelSpec = ASStackLayoutSpec(direction: ASStackLayoutDirection.Vertical, spacing: 0.0, justifyContent: ASStackLayoutJustifyContent.Center, alignItems: ASStackLayoutAlignItems.Center, children: [labelNode])
        
        let verticalSpec = ASStackLayoutSpec(direction: ASStackLayoutDirection.Vertical, spacing: 8.0, justifyContent: ASStackLayoutJustifyContent.Center, alignItems: ASStackLayoutAlignItems.Stretch, children: [labelSpec, compareHorizontalSpec])
        verticalSpec.flexGrow = true
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10.0, left: 0.0, bottom: 10.0, right: 0.0), child: verticalSpec)
    }
    
    func setupProfileNode(label: String, value1: String, value2: String) {
        labelNode.attributedString = NSAttributedString(string: label.lowercaseString, attributes: [
            NSFontAttributeName: UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline),
            NSUnderlineStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue
            ])
        labelNode.placeholderColor = UIColor.blackColor()
        
        firstValueNode.attributedString = NSAttributedString(string: value1, attributes: [
            NSFontAttributeName: UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
            ])
        firstValueNode.placeholderColor = UIColor.blackColor()
        
        secondValueNode.attributedString = NSAttributedString(string: value2, attributes: [
            NSFontAttributeName: UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
            ])
        secondValueNode.placeholderColor = UIColor.blackColor()
        
        addSubnode(labelNode)
        addSubnode(firstValueNode)
        addSubnode(secondValueNode)
    }
    
}