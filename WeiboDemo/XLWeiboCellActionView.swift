//
//  XLWeiboCellActionView.swift
//  WeiboDemo
//
//  Created by Jennifer on 26/12/15.
//  Copyright © 2015 Snowgan. All rights reserved.
//

import UIKit

class XLWeiboCellActionView: UIView {

    var repostButton: UIButton!
    var commentButton: UIButton!
    var likeButton: UIButton!
    var repostCount = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.whiteColor()
        
        let btnW = frame.width / 3
        // Repost
        repostButton = self.addButton("\(repostCount)", withImage: "timeline_icon_retweet")
        repostButton.frame = CGRect(x: 0.0, y: 0.0, width: btnW, height: frame.height)
        
        // Comment
        commentButton = self.addButton("Comment", withImage: "timeline_icon_comment")
        commentButton.frame = CGRect(x: btnW, y: 0.0, width: btnW, height: frame.height)
        
        // Like
        likeButton = self.addButton("Like", withImage: "timeline_icon_unlike")
        likeButton.frame = CGRect(x: btnW * 2, y: 0.0, width: btnW, height: frame.height)
        
        let path = UIBezierPath()
        let p1 = CGPoint(x: 0.0, y: frame.height)
        let p2 = CGPoint(x: frame.width, y: frame.height)
        let p3 = CGPoint(x: frame.width, y: frame.height + 0.3)
        let p4 = CGPoint(x: 0.0, y: frame.height + 0.3)
        
        path.moveToPoint(p1)
        path.addLineToPoint(p2)
        path.addLineToPoint(p3)
        path.addLineToPoint(p4)
        path.closePath()
        
        self.layer.shadowPath = path.CGPath
        self.layer.shadowOffset = CGSizeZero
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 0.5
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    func addButton(title: String, withImage image: String) -> UIButton {
        let btn = UIButton()
        btn.setImage(UIImage(named: image), forState: .Normal)
        btn.setTitle(title, forState: .Normal)
        btn.setTitleColor(actionTextColor, forState: .Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(10)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 5.0, bottom: 0.0, right: 0.0)
        self.addSubview(btn)
        return btn
    }
}
