//
//  XLWeiboTextView.swift
//  WeiboDemo
//
//  Created by Jennifer on 2/2/16.
//  Copyright © 2016 Snowgan. All rights reserved.
//

import UIKit

class XLWeiboTextView: UITextView {

    var links: [XLAttributedTextLink]?
    var tappedLink: XLAttributedTextLink?
    var tappedLinkRects: [CGRect]?
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    // MARK: - Touch Event Handling
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first!
        let point = touch.locationInView(self)
        tappedLink = linkAtPoint(point)
        if tappedLink == nil {
            super.touchesBegan(touches, withEvent: event)
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let curLink = tappedLink {
            let touch = touches.first!
            let point = touch.locationInView(self)
            guard curLink == linkAtPoint(point) else {
                tappedLink = nil
                return
            }
        } else {
            super.touchesMoved(touches, withEvent: event)
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let curLink = tappedLink {
            print(curLink.linkValue)
            addTapShadowForLink(curLink)
            
            // To do After Tapping Link
            
        } else {
            super.touchesEnded(touches, withEvent: event)
        }
    }
    
    func linkAtPoint(point: CGPoint) -> XLAttributedTextLink? {
        var link: XLAttributedTextLink?
        
        if let links = links {
            for l in links {
                if isLink(l, containPoint: point) {
                    link = l
                    break
                }
            }
        }
        
        return link
    }
    
    func isLink(link: XLAttributedTextLink, containPoint point: CGPoint) -> Bool {
        var contained = false
        selectedRange = link.range
        let rects = selectionRectsForRange(selectedTextRange!)
        selectedRange = NSRange(location: 0, length: 0)
        
        for curRect in rects {
            let rect = (curRect as! UITextSelectionRect).rect
            if rect.width == 0 || rect.height == 0 {
                continue
            }
            if CGRectContainsPoint(rect, point) {
                contained = true
                tappedLinkRects = rects.map { ($0 as! UITextSelectionRect).rect }
                break
            }
        }
        return contained
    }
    
    func addTapShadowForLink(link: XLAttributedTextLink) {
        
        for rect in tappedLinkRects! {
            if rect.width == 0 || rect.height == 0 {
                continue
            }
            let shadowLayer = CALayer()
            shadowLayer.frame = rect
            shadowLayer.cornerRadius = 2
            shadowLayer.backgroundColor = linkShadowColor.CGColor
            shadowLayer.opacity = 0.6
            layer.addSublayer(shadowLayer)
        }
    }
}
