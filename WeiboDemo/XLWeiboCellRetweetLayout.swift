//
//  XLWeiboCellRetweetLayout.swift
//  WeiboDemo
//
//  Created by Jennifer on 26/12/15.
//  Copyright © 2015 Snowgan. All rights reserved.
//

import Foundation

class XLWeiboCellRetweetLayout {
    
    let statusData: XLRetweetStatus
    
    var textViewLayout: (font: UIFont, frame: CGRect)!
    
    var retweetHeight: CGFloat {
        return 2*kWeiboCellMargin + textViewLayout.frame.height
    }
    
    init(withStatusData status: XLRetweetStatus) {
        statusData = status
        
        textViewLayout = setTextView()
    }
    
    func setTextView() -> (UIFont, CGRect) {
        let textStr: NSString = statusData.retweetText
        let textFont = UIFont.systemFontOfSize(13)
        let textX = kWeiboCellMargin
        let textY = kWeiboCellMargin
        let maxW = windowFrame.width - 2 * kWeiboCellMargin
        let maxSize = CGSize(width: maxW, height: CGFloat.max)
        let textSize = textStr.boundingRectWithSize(maxSize, options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName: textFont], context: nil).size
        let textFrame = CGRect(origin: CGPoint(x: textX, y: textY), size: textSize)
        return (textFont, textFrame)
    }
    
}