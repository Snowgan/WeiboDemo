//
//  XLMultiStatus.swift
//  WeiboDemo
//
//  Created by Jennifer on 14/12/15.
//  Copyright © 2015 Snowgan. All rights reserved.
//

import Foundation
import SwiftyJSON

class XLMultiStatus {
    
    var statusArr: [XLStatus]!
    
    var statusLayoutArr: [XLWeiboCellLayout]!
    
    init() {
        statusArr = [XLStatus]()
        statusLayoutArr = [XLWeiboCellLayout]()
    }
    
    init(withJSON json: JSON) {
        statusArr = [XLStatus]()
        statusLayoutArr = [XLWeiboCellLayout]()
        let statuses = json["statuses"]
        let count = statuses.count
        for i in 0..<count {
            let status = XLStatus()
            let origStatus = XLOriginalStatus()
            let curStatus = statuses[i]
            origStatus.profileURLString = curStatus["user"]["profile_image_url"].string
            origStatus.nameString = curStatus["user"]["name"].string
            origStatus.sourceString = curStatus["source"].string?.deleteHTMLString()
            origStatus.createTimeString = curStatus["created_at"].string
            origStatus.text = curStatus["text"].string
            status.repostsCount = curStatus["reposts_count"].int!
            status.original = origStatus
            
            // Retweet
            if let retweet = curStatus["retweeted_status"].dictionary {
                let retwStatus = XLRetweetStatus()
                if retweet["user"] != nil {
                    retwStatus.nameString = retweet["user"]!["name"].string
                }
                retwStatus.retweetText = retweet["text"]?.string
                status.retweet = retwStatus
            }
            
            statusArr.append(status)
            
            let layout = XLWeiboCellLayout(withStatusData: status)
            
//            let layout = XLWeiboCellOriginalLayout(withStatusData: status)
            statusLayoutArr.append(layout)
        }
    }
}

extension String {
    func deleteHTMLString() -> String {
        var cleanString = self
        let startInd = self.rangeOfString(">")?.endIndex
        let endInd = self.rangeOfString("</")?.first
        if let s = startInd, e = endInd {
            cleanString = self[s..<e]
        }
        return cleanString
    }
}