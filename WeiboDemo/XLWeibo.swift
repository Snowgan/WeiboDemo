//
//  XLWeibo.swift
//  WeiboDemo
//
//  Created by Jennifer on 29/11/15.
//  Copyright © 2015 Snowgan. All rights reserved.
//

import Foundation

class XLWeibo: NSObject {
    var profileURLString: String!
    var nameString: String!
    var sourceString: String!
    var createTimeString: String!
    var source: String {
        return convertTime(createTimeString) + "from" + sourceString
    }
    var text: String!
    
    func convertTime(time: String) -> String{
        
        //Sun Nov 29 20:07:45 +0800 2015
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "E MMM d HH:mm:ss Z yyyy"
        let date = dateFormatter.dateFromString(time)
        dateFormatter.dateFormat = "MM-dd"
        return dateFormatter.stringFromDate(date!)
    }
    
}