//
//  XLPicStatus.swift
//  WeiboDemo
//
//  Created by Jennifer on 16/2/16.
//  Copyright © 2016 Snowgan. All rights reserved.
//

import Foundation

class XLPicStatus: NSObject {
    
    var picsURL: [[String: String]]
    
    var isRetweet: Bool
    
    var thumbPicsURL: [String] {
        return picsURL.map { $0["thumbnail_pic"]! }
    }
    
//    // Generate middle pictures' URL
//    var middlePicsURL: [String] {
//        let thumb = picsURL.map { $0["thumbnail_pic"]! }
//        return thumb.map { ($0 as NSString).stringByReplacingOccurrencesOfString("thumbnail", withString: "bmiddle") }
//    }
    
    init(withPics pics: [[String: String]], retweet re: Bool) {
        picsURL = pics
        isRetweet = re
        super.init()
    }
    
    override init() {
        picsURL = []
        isRetweet = false
        super.init()
    }
    
}