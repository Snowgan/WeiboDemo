//
//  XLWeiboCellLayout.swift
//  WeiboDemo
//
//  Created by Jennifer on 26/12/15.
//  Copyright © 2015 Snowgan. All rights reserved.
//

import Foundation

class XLWeiboCellLayout {
    
    var statusData: XLStatus
    
    var origViewLayout: XLWeiboCellOriginalLayout!
    
    var retwViewLayout: XLWeiboCellRetweetLayout?
    
    var height: CGFloat {
        var h = origViewLayout.origHeight
        if retwViewLayout != nil {
            h += retwViewLayout!.retweetHeight
        }
        return h
    }
    
    init(withStatusData status: XLStatus) {
        statusData = status

        origViewLayout = XLWeiboCellOriginalLayout(withStatusData: statusData.original)
        
        if let retweet = statusData.retweet {
            retwViewLayout = XLWeiboCellRetweetLayout(withStatusData: retweet)
        }
        
    }
}