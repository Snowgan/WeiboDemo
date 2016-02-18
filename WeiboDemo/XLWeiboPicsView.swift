//
//  XLWeiboPicsView.swift
//  WeiboDemo
//
//  Created by Jennifer on 14/2/16.
//  Copyright © 2016 Snowgan. All rights reserved.
//

import UIKit

class XLWeiboPicsView: UIImageView {
    
    var status: XLPicStatus! {
        didSet {
            setupStatus(status)
        }
    }

    var picsLayout: XLWeiboPicsLayout! {
        didSet {
            setupLayout(picsLayout)
        }
    }
    
    init() {
        super.init(frame: CGRectZero)
        for _ in 0..<9 {
            let picView = XLWeiboPicView(frame: CGRect(x: 0, y: 0, width: homePicWH, height: homePicWH))
            self.addSubview(picView)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupStatus(status: XLPicStatus) {
        backgroundColor = status.isRetweet ? retweetColor : UIColor.whiteColor()
        let urls = status.thumbPicsURL
        let picsCount = urls.count
        for i in 0..<9 {
            let picView = subviews[i] as! XLWeiboPicView
            if i < picsCount {
                picView.url = urls[i]
                picView.hidden = false
            } else {
                picView.hidden = true
            }
        }
    }
    
    func setupLayout(layout: XLWeiboPicsLayout) {
        let picsCount = layout.statusData.picsURL.count
        for i in 0..<picsCount {
           let picView = subviews[i] as! XLWeiboPicView
           picView.frame.origin = layout.picsOrigin[i]
        }
        frame.size = CGSize(width: windowFrame.width, height: layout.picsHeight)
    }
}
