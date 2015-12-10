//
//  XLCommonFile.swift
//  WeiboDemo
//
//  Created by Jennifer on 29/11/15.
//  Copyright © 2015 Snowgan. All rights reserved.
//

import Foundation

//UI
let windowFrame = UIScreen.mainScreen().bounds
let bgColor = UIColor(red: 246.0/255.0, green: 246.0/255.0, blue: 246.0/255.0, alpha: 1.0)
let windowCenterX = windowFrame.width / 2.0
let kWeiboCellMargin = 10
let kWeiboCellInset = 7

//Weibo API data
let kAppKey = "2790170142"

//Notification
let WBTokenDidSetNotification = "WBTokenDidSet"

// MARK: - Globle Functions

func delay(seconds seconds: NSTimeInterval, completion: ()->()) {
    let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(Double(NSEC_PER_SEC) * seconds))
    
    dispatch_after(delayTime, dispatch_get_main_queue()) {
        completion()
    }
}

