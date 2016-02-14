//
//  SchoolNode.swift
//  schoolFinder
//
//  Created by Jonathan Yu on 2/12/16.
//  Copyright © 2016 Jonathan Yu. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class SchoolNode: ASCellNode {
    
    var titleNode: ASTextNode
    var subtitleNode: ASTextNode
    var typeNode: ASTextNode
    
    init!(result: Result) {
        titleNode = ASTextNode()
        subtitleNode = ASTextNode()
        typeNode = ASTextNode()
        
        super.init()
        setupSubNodesWithItem(result)
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let verticalNodeStack = ASStackLayoutSpec(direction: ASStackLayoutDirection.Vertical, spacing: 8.0, justifyContent: ASStackLayoutJustifyContent.End, alignItems: ASStackLayoutAlignItems.BaselineFirst, children: [titleNode, subtitleNode, typeNode])
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 5.0, left: 10.0, bottom: 5.0, right: 10.0), child: verticalNodeStack)
    }
    
    func setupSubNodesWithItem(result: Result) {
        titleNode.attributedString = NSAttributedString(string: result.NAME!, attributes: [
            NSFontAttributeName: UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
            ])
        titleNode.placeholderColor = UIColor.blackColor()
        
        subtitleNode.attributedString = NSAttributedString(string: result.STATE!, attributes: [
            NSFontAttributeName: UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
            ])
        typeNode.attributedString = NSAttributedString(string: result.SCHOOL_URL!, attributes: [
            NSFontAttributeName: UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline),
            NSForegroundColorAttributeName: UIColor.blueColor()
            ])
        
        addSubnode(titleNode)
        addSubnode(subtitleNode)
        addSubnode(typeNode)
    }
    
}