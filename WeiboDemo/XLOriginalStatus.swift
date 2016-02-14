//
//  XLOriginalStatus.swift
//  WeiboDemo
//
//  Created by Jennifer on 28/12/15.
//  Copyright © 2015 Snowgan. All rights reserved.
//

import Foundation

enum XLDateRange {
    case Today, Yesterday, ThisYear, OtherDay
}

class XLOriginalStatus: XLBasicStatus {
    
    var profileURLString: String!
    var nameString: String!
    var sourceString: String!
    var createTimeString: String!
    var source: String {
        return convertTime(createTimeString) + " from " + sourceString
    }
//    var text: String!
//    var attributeText: NSMutableAttributedString {
//        return addAttributeForText(text)
//    }
//    
//    var links: [XLAttributedTextLink]?
    
    func convertTime(time: String) -> String{
        
        var dateString = ""
        
        //Sun Nov 29 20:07:45 +0800 2015
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "E MMM d HH:mm:ss Z yyyy"
        let date = dateFormatter.dateFromString(time)
        
        let calendar = NSCalendar.currentCalendar()
        let unitFlag: NSCalendarUnit = [.Hour, .Minute, .Second]
        let compts = calendar.components(unitFlag, fromDate: date!, toDate: NSDate(), options: NSCalendarOptions(rawValue: 0))
        switch date!.dateRange() {
        case .Today:
            if compts.hour >= 1 {
                dateString = "\(compts.hour) hours ago"
            } else if compts.minute >= 1 {
                dateString = "\(compts.minute) mins ago"
            } else {
                dateString = "Just now"
            }
        case .Yesterday:
            dateString = "Yesterday"
            dateFormatter.dateFormat = "HH:mm"
            dateString += dateFormatter.stringFromDate(date!)
        case .ThisYear:
            dateFormatter.dateFormat = "MM-dd HH:mm"
            dateString = dateFormatter.stringFromDate(date!)
        case .OtherDay:
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dateString = dateFormatter.stringFromDate(date!)
        }
        
        return dateString
    }
    
//    func addAttributeForText(text: String) -> NSMutableAttributedString {
//        let attrStr = NSMutableAttributedString(string: text)
//        let textRange = NSRange(location: 0, length: text.characters.count)
//        
//        // Username Tappable
//        let namePattern = "@[^@\\s]+?[:|\\s]"
//        let nameRegExp = try! NSRegularExpression(pattern: namePattern, options: NSRegularExpressionOptions(rawValue: 0))
//        let nameMatchs = nameRegExp.matchesInString(text, options: NSMatchingOptions(rawValue: 0), range: textRange)
//        if nameMatchs.count != 0 {
//            links = [XLAttributedTextLink]()
//        }
//        for match in nameMatchs {
//            let range = NSRange(location: match.range.location, length: match.range.length-1)
//            let link = XLAttributedTextLink(withRange: range)
//            let valueRange = NSRange(location: match.range.location+1, length: match.range.length-2)
//            link.linkValue = (text as NSString).substringWithRange(valueRange)
//            links!.append(link)
//            print(link.linkValue)
//            attrStr.addAttributes(link.attributes, range: link.range)
//        }
//        
//        return attrStr
//    }
    
}

extension NSDate {
    
    func dateRange() -> XLDateRange{
        let calendar = NSCalendar.currentCalendar()
        let unitFlag: NSCalendarUnit = [.Day, .Month, .Year]
        let nowComps = calendar.components(unitFlag, fromDate: NSDate())
        let selfComps = calendar.components(unitFlag, fromDate: self)
        
        if selfComps.year == nowComps.year {
            if (selfComps.month == nowComps.month) && (selfComps.day == nowComps.day) {
                return XLDateRange.Today
            } else if (selfComps.month == nowComps.month) && (selfComps.day + 1 == nowComps.day) {
                return XLDateRange.Yesterday
            } else {
                return XLDateRange.ThisYear
            }
        } else {
            return XLDateRange.OtherDay
        }
        
    }
    
}