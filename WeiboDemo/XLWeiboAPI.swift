//
//  XLWeiboAPI.swift
//  WeiboDemo
//
//  Created by Jennifer on 4/12/15.
//  Copyright © 2015 Snowgan. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

typealias CompleteHandle = ((responseJSONData: JSON) -> ())

class XLWeiboAPI: NSObject {
    
    private override init() {
        super.init()
    }
    
    static let sharedWeiboAPI = XLWeiboAPI()
    
    func requestWithURL(urlString: String, params: [String: AnyObject], completeHandle: CompleteHandle) {
        
        Alamofire.request(.GET, urlString, parameters: params).response { (request, response, data, error) -> Void in
            if data != nil {
                let json = JSON(data: data!)
                completeHandle(responseJSONData: json)
            }
        }
    }

    
}