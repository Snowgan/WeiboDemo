//
//  XLWeiboCell.swift
//  WeiboDemo
//
//  Created by Jennifer on 29/11/15.
//  Copyright © 2015 Snowgan. All rights reserved.
//

import UIKit

class XLWeiboCell: UITableViewCell {

    var originalView: XLWeiboCellOriginalView!
    
    var retweetView: XLWeiboCellRetweetView?
    
    var actionView: XLWeiboCellActionView!
    
    var picsView: XLWeiboPicsView?
    
    var layout: XLWeiboCellLayout! {
        didSet {
            originalView.origViewLayout = layout.origViewLayout
            
            if let retweetV = retweetView {
                retweetV.frame.origin.y = layout.origViewLayout.origHeight
                retweetV.retwViewLayout = layout.retwViewLayout
            }
            
            if let picsV = picsView {
                picsV.frame.origin.y = layout.origViewLayout.origHeight
                picsV.picsLayout = layout.picsViewLayout
                if picsV.status.isRetweet {
                    picsV.frame.origin.y += retweetView!.retwViewLayout.retweetHeight
                }
            }
            
            actionView.frame.origin.y = layout.height + 1.0
        }
    }
    
    var status: XLStatus! {
        didSet {
            originalView.status = status.original
            
            if let retweet = status.retweet {
                if retweetView == nil {
                    let retwV = XLWeiboCellRetweetView()
                    contentView.addSubview(retwV)
                    retweetView = retwV
                }
                retweetView!.status = retweet
            } else if retweetView != nil {
                retweetView!.removeFromSuperview()
                retweetView = nil
            }
            
//            if picsView != nil {
//                picsView!.removeFromSuperview()
//                picsView = nil
//            }
            
            if let pictures = status.pictures {
                if picsView == nil {
                    let picsV = XLWeiboPicsView()
                    contentView.addSubview(picsV)
                    picsView = picsV
                }
                picsView!.status = pictures
            } else if picsView != nil {
                picsView!.removeFromSuperview()
                picsView = nil
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = bgColor
        
        let origV = XLWeiboCellOriginalView()
        self.contentView.addSubview(origV)
        self.originalView = origV
        
        let actV = XLWeiboCellActionView(frame: CGRect(x: 0.0, y: 0.0, width: windowFrame.width, height: 30.0))
        self.contentView.addSubview(actV)
        self.actionView = actV
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
