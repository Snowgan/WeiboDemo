//
//  XLRetweetStatus.swift
//  WeiboDemo
//
//  Created by Jennifer on 27/12/15.
//  Copyright © 2015 Snowgan. All rights reserved.
//

import Foundation

class XLRetweetStatus: NSObject {
    
    var nameString: String!
    var text: String!
    
    var retweetText: String {
        return "@\(nameString): \(text)"
    }
    
}