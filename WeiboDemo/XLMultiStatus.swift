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
    
    var lastStatusID: NSNumber
    
    var statusArr: [XLStatus]!
    
    var statusLayoutArr: [XLWeiboCellLayout]!
    
    init() {
        lastStatusID = NSNumber(longLong: 0)
        statusArr = [XLStatus]()
        statusLayoutArr = [XLWeiboCellLayout]()
    }
    
    init(withJSON json: JSON) {
        let statuses = json["statuses"]
        let count = statuses.count
        lastStatusID = statuses[count-1]["id"].numberValue
        statusArr = [XLStatus]()
        statusLayoutArr = [XLWeiboCellLayout]()
        
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
                if let pics = retweet["pic_urls"]!.array where pics.count != 0 {
                    status.pictures = picStatusWithJSON(pics, isRetweet: true)
                }
            } else if let pics = curStatus["pic_urls"].array where pics.count != 0 {
                status.pictures = picStatusWithJSON(pics, isRetweet: false)
            }
            
            statusArr.append(status)
            
            let layout = XLWeiboCellLayout(withStatusData: status)
            
//            let layout = XLWeiboCellOriginalLayout(withStatusData: status)
            statusLayoutArr.append(layout)
        }
        
    }
    
    func picStatusWithJSON(json: [JSON], isRetweet: Bool) -> XLPicStatus {
        let picStatus = json.map { (ele: JSON) -> [String: String] in
            var output = [String: String]()
            let jsonDic = ele.dictionary!
            for key in jsonDic.keys {
                output[key] = jsonDic[key]!.string
            }
            return output
        }
        return XLPicStatus(withPics: picStatus, retweet: isRetweet)
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