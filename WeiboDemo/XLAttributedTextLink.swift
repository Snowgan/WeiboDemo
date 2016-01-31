//
//  XLAttributedTextLink.swift
//  WeiboDemo
//
//  Created by Jennifer on 29/1/16.
//  Copyright © 2016 Snowgan. All rights reserved.
//

import Foundation

class XLAttributedTextLink {
    
    var range: NSRange
    
    var attributes: [String: AnyObject]
    
    var linkValue: String
    
    convenience init(withRange range: NSRange) {
        let attrDic = [NSForegroundColorAttributeName: linkColor]
        self.init(withRange: range, attributes: attrDic, linkValue: "")
    }
    
    init(withRange range: NSRange, attributes attrs: [String: AnyObject], linkValue value: String) {
        self.range = range
        self.attributes = attrs
        self.linkValue = value
    }
}