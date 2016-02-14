//
//  XLWeiboCellRetweetView.swift
//  WeiboDemo
//
//  Created by Jennifer on 27/12/15.
//  Copyright © 2015 Snowgan. All rights reserved.
//

import UIKit

class XLWeiboCellRetweetView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    var status: XLRetweetStatus! {
        didSet {
            setupStatus(status)
        }
    }
    
    var retwViewLayout: XLWeiboCellRetweetLayout! {
        didSet {
            setupLayout(retwViewLayout)
        }
    }
    
    var textView: XLWeiboTextView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = retweetColor
        
        let textV = XLWeiboTextView()
        textV.backgroundColor = UIColor.clearColor()
        textV.editable = false
        textV.scrollEnabled = false
        textV.textContainerInset = UIEdgeInsetsZero
        textV.textContainer.lineFragmentPadding = 0
//        textV.userInteractionEnabled = false
        self.addSubview(textV)
        self.textView = textV
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupStatus(status: XLRetweetStatus) {
//        textView.text = status.retweetText
        textView.attributedText = status.attributedText
        textView.links = status.links
    }
    
    func setupLayout(layout: XLWeiboCellRetweetLayout) {
        textView.font = layout.textViewLayout.font
        
        textView.frame = layout.textViewLayout.frame
        
        self.frame.size = CGSize(width: windowFrame.width, height: layout.retweetHeight)
    }
    
}
