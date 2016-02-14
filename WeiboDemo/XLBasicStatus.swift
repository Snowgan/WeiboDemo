//
//  XLBasicStatus.swift
//  WeiboDemo
//
//  Created by Jennifer on 31/1/16.
//  Copyright © 2016 Snowgan. All rights reserved.
//

import Foundation

enum XLMatchType {
    case Username, Topic, Link
}

struct XLMatchResult {
    var result: NSTextCheckingResult
    var type: XLMatchType
    var value: String
}

class XLBasicStatus: NSObject {
    var text: String!
    var attributedText: NSMutableAttributedString {
        return addAttributeForText(text)
    }
    
    var links: [XLAttributedTextLink]?
    var matchResults = [XLMatchResult]()
    
    func addAttributeForText(var text: String) -> NSMutableAttributedString {
        var attrStr = NSMutableAttributedString(string: text)
        var textRange = NSRange(location: 0, length: text.characters.count)
        
        // Emoticons
        
        let emoPattern = "\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+?\\]"
        let emoRegExp = try! NSRegularExpression(pattern: emoPattern, options: .CaseInsensitive)
        let emoMatchs = emoRegExp.matchesInString(text, options: NSMatchingOptions(rawValue: 0), range: textRange)
        if !emoMatchs.isEmpty {
            let emoPath = NSBundle.mainBundle().pathForResource("emoticons", ofType: "plist")!
            let emoArray = NSArray(contentsOfFile: emoPath)!
            
            for match in emoMatchs.reverse() {
                let emoStr = (text as NSString).substringWithRange(match.range)
                for i in 0..<emoArray.count {
                    let curEmo = emoArray[i] as! NSDictionary
                    let curEmoName = curEmo["chs"] as! String
                    if curEmoName == emoStr {
                        let emoAttach = NSTextAttachment()
                        emoAttach.image = UIImage(named: (curEmo["png"] as! String))?.resizeImageWithWidth(12)
                        let emoAttrStr = NSAttributedString(attachment: emoAttach)
                        attrStr.replaceCharactersInRange(match.range, withAttributedString: emoAttrStr)
                    }
                }
            }
            
            text = attrStr.string
            textRange = NSMakeRange(0, text.characters.count)
        }
        
        // URL Tappable: "http(s)://..."
        let urlDetector = try! NSDataDetector(types: NSTextCheckingType.Link.rawValue)
        let urlMatchs = urlDetector.matchesInString(text, options: NSMatchingOptions(rawValue: 0), range: textRange)
        if urlMatchs.count != 0 {
            let mutableText = NSMutableString(string: text)
            
            for match in urlMatchs.reverse() {
                let res = XLMatchResult(result: match, type: .Link, value: mutableText.substringWithRange(match.range))
                matchResults.insert(res, atIndex: 0)
                mutableText.replaceCharactersInRange(match.range, withString: "网页链接")
            }
            
            text = mutableText as String
            textRange = NSMakeRange(0, text.characters.count)
            attrStr = NSMutableAttributedString(string: text)
            
            let linkPattern = "网页链接"
            let linkRegExp = try! NSRegularExpression(pattern: linkPattern, options: NSRegularExpressionOptions(rawValue: 0))
            let linkMatchs = linkRegExp.matchesInString(text, options: NSMatchingOptions(rawValue: 0), range: textRange)
            if urlMatchs.count == linkMatchs.count {
                for i in 0..<linkMatchs.count {
                    matchResults[i].result = linkMatchs[i]
                }
            } else {
                print("Link Match Error!")
                matchResults.removeAll()
            }
        }
        
        // Username Tappable: "@..."
        let namePattern = "@[^@\\s]+?[:|\\s]"
        let nameRegExp = try! NSRegularExpression(pattern: namePattern, options: NSRegularExpressionOptions(rawValue: 0))
        let nameMatchs = nameRegExp.matchesInString(text, options: NSMatchingOptions(rawValue: 0), range: textRange)
        for match in nameMatchs {
            let res = XLMatchResult(result: match, type: .Username, value: "")
            matchResults.append(res)
        }
        
        // Topic Tappable: "#...#"
        let topicPattern = "#[^#]+?#"
        let topicRegExp = try! NSRegularExpression(pattern: topicPattern, options: NSRegularExpressionOptions(rawValue: 0))
        let topicMatchs = topicRegExp.matchesInString(text, options: NSMatchingOptions(rawValue: 0), range: textRange)
        for match in topicMatchs {
            let res = XLMatchResult(result: match, type: .Topic, value: "")
            matchResults.append(res)
        }
        
        
        
        if matchResults.count != 0 {
            links = [XLAttributedTextLink]()
            var attrRange = NSRange()
            var linkValue = ""
            
            for res in matchResults {
                attrRange = res.result.range
                switch res.type {
                case .Username:
                    attrRange = NSMakeRange(attrRange.location, attrRange.length-1)
                    linkValue = (text as NSString).substringWithRange(NSMakeRange(attrRange.location+1, attrRange.length-1))
                case .Topic:
                    linkValue = (text as NSString).substringWithRange(NSMakeRange(attrRange.location+1, attrRange.length-2))
                case .Link:
                    linkValue = res.value
                }
                
                let link = XLAttributedTextLink(withRange: attrRange)
                link.linkValue = linkValue
                links!.append(link)
                print(link.linkValue)
                attrStr.addAttributes(link.attributes, range: link.range)
            }
        }
        
        return attrStr
    }
}

extension UIImage {
    func resizeImageWithWidth(width: CGFloat) -> UIImage {
        let scale = width / self.size.width
        let height = self.size.height * scale
        UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), false, 0.0)
        self.drawInRect(CGRect(x: 0, y: 0, width: width, height: height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
