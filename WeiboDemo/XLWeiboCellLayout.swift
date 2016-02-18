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
    
    var picsViewLayout: XLWeiboPicsLayout?
    
    var height: CGFloat {
        var h = origViewLayout.origHeight
        if retwViewLayout != nil {
            h += retwViewLayout!.retweetHeight
        }
        if picsViewLayout != nil {
            h += picsViewLayout!.picsHeight
        }
        return h
    }
    
    init(withStatusData status: XLStatus) {
        statusData = status

        origViewLayout = XLWeiboCellOriginalLayout(withStatusData: statusData.original)
        
        if let retweet = statusData.retweet {
            retwViewLayout = XLWeiboCellRetweetLayout(withStatusData: retweet)
        }
        
        if let picture = statusData.pictures {
            picsViewLayout = XLWeiboPicsLayout(withStatusData: picture)
        }
    }
}