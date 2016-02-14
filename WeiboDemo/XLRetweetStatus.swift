//
//  XLRetweetStatus.swift
//  WeiboDemo
//
//  Created by Jennifer on 27/12/15.
//  Copyright © 2015 Snowgan. All rights reserved.
//

import Foundation

class XLRetweetStatus: XLBasicStatus {
    
    var nameString: String!
//    override var text: String! {
//        return "@\(nameString): \(retweetText)"
//    }
    
    var retweetText: String! {
        get {
            return text
        }
        set {
            text = (nameString != nil) ? "@\(nameString): \(newValue)" : "\(newValue)"
        }
    }
    
}