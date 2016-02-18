//
//  XLCommonFile.swift
//  WeiboDemo
//
//  Created by Jennifer on 29/11/15.
//  Copyright © 2015 Snowgan. All rights reserved.
//

import Foundation

// UI
let windowFrame = UIScreen.mainScreen().bounds
let themeColor = UIColor(red: 254/255.0, green: 129/255.0, blue: 0, alpha: 1.0)
let bgColor = UIColor(red: 246.0/255.0, green: 246.0/255.0, blue: 246.0/255.0, alpha: 1.0)
let actionTextColor = UIColor(red: 127.0/255.0, green: 127.0/255.0, blue: 127.0/255.0, alpha: 1.0)
let retweetColor = UIColor(red: 243.0/255.0, green: 243.0/255.0, blue: 243.0/255.0, alpha: 1.0)
let linkColor = UIColor(red: 68.0/255.0, green: 102.0/255.0, blue: 153.0/255.0, alpha: 1.0)
let linkShadowColor = UIColor(red: 176.0/255.0, green: 213.0/255.0, blue: 250.0/255.0, alpha: 1.0)
let windowCenterX = windowFrame.width / 2.0
let kWeiboCellMargin: CGFloat = 10.0
let kWeiboCellInset: CGFloat = 5.0
let bodyFont = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
let subHeadFont = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
let homePicWH: CGFloat = 76
let homePicInset: CGFloat = 3.0

// Table View
let kXLHomeCellIdentifier = "homeTableCell"

// Weibo API data
let kAppKey = "2790170142"

// Notification
let WBTokenDidSetNotification = "WBTokenDidSet"

// MARK: - Globle Functions

func delay(seconds seconds: NSTimeInterval, completion: ()->()) {
    let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(Double(NSEC_PER_SEC) * seconds))
    
    dispatch_after(delayTime, dispatch_get_main_queue()) {
        completion()
    }
}

