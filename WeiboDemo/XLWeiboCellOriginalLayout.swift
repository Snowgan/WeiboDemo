//
//  XLWeiboCellOriginalLayout.swift
//  WeiboDemo
//
//  Created by Jennifer on 11/12/15.
//  Copyright © 2015 Snowgan. All rights reserved.
//

import Foundation

class XLWeiboCellOriginalLayout {
    
    let statusData: XLOriginalStatus
    
    var profileImageFrame: CGRect!
    
    var nameLabelLayout: (font: UIFont, frame: CGRect)!
    
    var sourceLabelLayout: (font: UIFont, frame: CGRect)!
    
    var textViewLayout: (font: UIFont, frame: CGRect)!
    
    var origHeight: CGFloat {
        return 2*kWeiboCellMargin + kWeiboCellInset + profileImageFrame.height + textViewLayout.frame.height
    }
    // Profile Image Frame
    
    init(withStatusData status: XLOriginalStatus) {
        statusData = status
        
        profileImageFrame = proImageFrame()
        
        nameLabelLayout = setNameLabel()
        
        sourceLabelLayout = setSourceLabel()
        
        textViewLayout = setTextView()
        
    }
    
    func proImageFrame() -> CGRect {
        let imW: CGFloat = 30.0
        let imH: CGFloat = 30.0
        
        let imFrame = CGRect(x: kWeiboCellMargin, y: kWeiboCellMargin, width: imW, height: imH)
        
        return imFrame
    }
    
    func setNameLabel() -> (UIFont, CGRect) {
        let nameStr: NSString = statusData.nameString
        let nameFont = UIFont.systemFontOfSize(13)
        let nameSize = nameStr.sizeWithAttributes([NSFontAttributeName: nameFont])
        let nameX = profileImageFrame.origin.x + profileImageFrame.width + kWeiboCellInset
        let nameFrame = CGRect(origin: CGPoint(x: nameX, y: kWeiboCellMargin), size: nameSize)
        
        return (nameFont, nameFrame)
    }
    
    func setSourceLabel() -> (UIFont, CGRect) {
        let sourceStr: NSString =  statusData.source
        let sourceFont = UIFont.systemFontOfSize(10)
        let sourceSize = sourceStr.sizeWithAttributes([NSFontAttributeName: sourceFont])
        let sourceX = profileImageFrame.origin.x + profileImageFrame.width + kWeiboCellInset
        let sourceY = nameLabelLayout.frame.height + kWeiboCellMargin + 3
        let sourceFrame = CGRect(origin: CGPoint(x: sourceX, y: sourceY), size: sourceSize)
        
        return (sourceFont, sourceFrame)
    }
    
    func setTextView() -> (UIFont, CGRect) {
        let textStr: NSString = statusData.text
        let textFont = UIFont.systemFontOfSize(13)
        let textX = kWeiboCellMargin
        let textY = kWeiboCellMargin + profileImageFrame.height + kWeiboCellInset
        let maxW = windowFrame.width - 2 * kWeiboCellMargin
        let maxSize = CGSize(width: maxW, height: CGFloat.max)
        let textSize = textStr.boundingRectWithSize(maxSize, options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName: textFont], context: nil).size
        let textFrame = CGRect(origin: CGPoint(x: textX, y: textY), size: textSize)
//        let textFrame = CGRect(x: textX, y: textY, width: textSize.width + 10, height: textSize.height + 16)
        return (textFont, textFrame)
    }
}