//
//  XLWeiboPicsLayout.swift
//  WeiboDemo
//
//  Created by Jennifer on 16/2/16.
//  Copyright © 2016 Snowgan. All rights reserved.
//

import Foundation

class XLWeiboPicsLayout {
    
    let statusData: XLPicStatus
    
    var picsOrigin: [CGPoint] {
        var origins = [CGPoint]()
        let picsCount = statusData.picsURL.count
        let rows = (picsCount - 1) / 3 + 1
        let cols = (picsCount == 4) ? 2 : ((rows > 1) ? 3 : picsCount)
        for i in 0..<rows {
            for j in 0..<cols {
                if i*cols+j < picsCount {
                    let origX = (homePicInset + homePicWH) * CGFloat(j) + kWeiboCellMargin
                    let origY = (homePicInset + homePicWH) * CGFloat(i)
                    origins.append(CGPoint(x: origX, y: origY))
                }
            }
        }
        return origins
    }
    
    var picsHeight: CGFloat {
        if !picsOrigin.isEmpty {
            return picsOrigin.last!.y + homePicWH + kWeiboCellMargin
        } else {
            return 0
        }
    }
    
    init(withStatusData status: XLPicStatus) {
        statusData = status
    }
    
}