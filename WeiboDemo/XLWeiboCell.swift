//
//  XLWeiboCell.swift
//  WeiboDemo
//
//  Created by Jennifer on 29/11/15.
//  Copyright © 2015 Snowgan. All rights reserved.
//

import UIKit

class XLWeiboCell: UITableViewCell {

    var layout: XLWeiboCellLayout! {
        didSet {
            originalView.origViewLayout = layout.origViewLayout
            
            if retweetView != nil {
                retweetView!.frame.origin.y = layout.origViewLayout.origHeight
                retweetView!.retwViewLayout = layout.retwViewLayout
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
        }
    }
    
    var originalView: XLWeiboCellOriginalView!
    
    var retweetView: XLWeiboCellRetweetView?
    
    var actionView: XLWeiboCellActionView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = bgColor
        
        let origV = XLWeiboCellOriginalView()
        self.contentView.addSubview(origV)
        self.originalView = origV
        
        let actV = XLWeiboCellActionView(frame: CGRect(x: 0.0, y: 0.0, width: windowFrame.width, height: 30.0))
        self.contentView.addSubview(actV)
        self.actionView = actV
        
//        actV.translatesAutoresizingMaskIntoConstraints = false
//        let actVYConstraint = NSLayoutConstraint(item: actV, attribute: .Top, relatedBy: .Equal, toItem: origV, attribute: .Bottom, multiplier: 1.0, constant: 1.0)
//        let actVXConstraint = NSLayoutConstraint(item: actV, attribute: .Leading, relatedBy: .Equal, toItem: origV, attribute: .Leading, multiplier: 1.0, constant: 0.0)
//        self.addConstraints([actVXConstraint, actVYConstraint])
//        self.addConstraints([actVXConstraint, actVYConstraint])
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
