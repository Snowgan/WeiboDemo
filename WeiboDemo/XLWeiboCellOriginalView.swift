//
//  XLWeiboCellOriginalView.swift
//  WeiboDemo
//
//  Created by Jennifer on 29/11/15.
//  Copyright © 2015 Snowgan. All rights reserved.
//

import UIKit
import Kingfisher

class XLWeiboCellOriginalView: UIView {

    var profileImage: UIImageView!
    var nameLabel: UILabel!
    var sourceLable: UILabel!
    var textView: XLWeiboTextView!
    var rightTopButton: XLWeiboCellRightTopButton!
//    var tappedLink: XLAttributedTextLink?
//    var tappedLinkRects: [CGRect]?
    
    var status: XLOriginalStatus! {
        didSet {
            setupStatus(status)
        }
    }
    var origViewLayout: XLWeiboCellOriginalLayout! {
        didSet {
            setupLayout(origViewLayout)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.whiteColor()
        
        //Profile Image
        let proImage = UIImageView()
        self.addSubview(proImage)
        self.profileImage = proImage
        
        //Name
        let nameL = UILabel()
        self.addSubview(nameL)
        nameLabel = nameL
        
        //Source
        let sourceL = UILabel()
        self.addSubview(sourceL)
        sourceLable = sourceL
        
        //Text
        let textV = XLWeiboTextView()
        textV.editable = false
        textV.scrollEnabled = false
        textV.textContainerInset = UIEdgeInsetsZero
        textV.textContainer.lineFragmentPadding = 0
//        textV.userInteractionEnabled = false
//        textV.dataDetectorTypes = .Link
        self.addSubview(textV)
        textView = textV
        
        //RightTop Button
        let rtBtn = XLWeiboCellRightTopButton()
        self.addSubview(rtBtn)
        rightTopButton = rtBtn
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupStatus(status: XLOriginalStatus) {
        
        profileImage.kf_setImageWithURL(NSURL(string: status.profileURLString)!)
        
        nameLabel.text = status.nameString
        
        sourceLable.text = status.source
        
//        textView.text = status.text
        textView.attributedText = status.attributedText
        textView.links = status.links
    }
    
    func setupLayout(layout: XLWeiboCellOriginalLayout) {
        
        profileImage.frame = layout.profileImageFrame
        profileImage.layer.cornerRadius = layout.profileImageFrame.width/2
        profileImage.layer.masksToBounds = true
        
        nameLabel.font = layout.nameLabelLayout.font
        
        nameLabel.frame = layout.nameLabelLayout.frame
        
        sourceLable.font = layout.sourceLabelLayout.font
        
        sourceLable.frame = layout.sourceLabelLayout.frame
        
        textView.font = layout.textViewLayout.font
        
        textView.frame = layout.textViewLayout.frame
        
//        self.frame = CGRect(x: 0.0, y: 0.0, width: windowFrame.width, height: layout.origHeight)
        self.frame.size = CGSize(width: windowFrame.width, height: layout.origHeight)
        
//        frame.size = CGSize(width: windowFrame.width, height: layout.origHeight)
    }
    
//    func addTapShadowForLink(link: XLAttributedTextLink) {
//        
//        for rect in tappedLinkRects! {
//            if rect.width == 0 || rect.height == 0 {
//                continue
//            }
//            let shadowLayer = CALayer()
//            shadowLayer.frame = rect
//            shadowLayer.cornerRadius = 3
//            shadowLayer.backgroundColor = linkShadowColor.CGColor
//            shadowLayer.opacity = 0.6
//            textView.layer.addSublayer(shadowLayer)
//        }
//    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

//    func textView(textView: UITextView, shouldInteractWithURL URL: NSURL, inRange characterRange: NSRange) -> Bool {
//        return true
//    }
    // MARK: - Touch Event Handling
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        let touch = touches.first!
//        let point = touch.locationInView(textView)
//        tappedLink = linkAtPoint(point)
//        if tappedLink == nil {
//            super.touchesBegan(touches, withEvent: event)
//        }
//    }
//    
//    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        if let curLink = tappedLink {
//            let touch = touches.first!
//            let point = touch.locationInView(textView)
//            guard curLink == linkAtPoint(point) else {
//                tappedLink = nil
//                return
//            }
//        } else {
//            super.touchesMoved(touches, withEvent: event)
//        }
//    }
//    
//    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        if let curLink = tappedLink {
//            print(curLink.linkValue)
//            addTapShadowForLink(curLink)
//            
//            // To do After Tapping Link
//            
//        } else {
//            super.touchesEnded(touches, withEvent: event)
//        }
//    }
//    
//    func linkAtPoint(point: CGPoint) -> XLAttributedTextLink? {
//        var link: XLAttributedTextLink?
//        
//        if let links = status.links {
//            for l in links {
//                if isLink(l, containPoint: point) {
//                    link = l
//                    break
//                }
//            }
//        }
//        
//        return link
//    }
//    
//    func isLink(link: XLAttributedTextLink, containPoint point: CGPoint) -> Bool {
//        var contained = false
//        textView.selectedRange = link.range
//        let rects = textView.selectionRectsForRange(textView.selectedTextRange!)
//        textView.selectedRange = NSRange(location: 0, length: 0)
//        
//        for curRect in rects {
//            let rect = (curRect as! UITextSelectionRect).rect
//            if rect.width == 0 || rect.height == 0 {
//                continue
//            }
//            if CGRectContainsPoint(rect, point) {
//                contained = true
//                tappedLinkRects = rects.map { ($0 as! UITextSelectionRect).rect }
//                break
//            }
//        }
//        return contained
//    }
    
}
