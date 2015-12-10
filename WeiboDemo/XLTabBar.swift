//
//  XLTabBar.swift
//  WeiboDemo
//
//  Created by Jennifer on 18/11/15.
//  Copyright © 2015 Snowgan. All rights reserved.
//

import UIKit

class XLTabBar: UITabBar {

    var composeButton: UIButton!
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        composeButton = UIButton()
        composeButton.setBackgroundImage(UIImage(named: "tabbar_compose_button"), forState: .Normal)
        composeButton.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), forState: .Highlighted)
        
        composeButton.setImage(UIImage(named: "tabbar_compose_icon_add"), forState: .Normal)
        composeButton.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), forState: .Highlighted)
        self.addSubview(composeButton)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let tabbarCount = items!.count
        print(tabbarCount)
        
        let tabbarItemW = bounds.width / CGFloat(tabbarCount + 1)
        let tabbarItamH = bounds.height
        
        composeButton.bounds.size = composeButton.currentBackgroundImage!.size
        composeButton.center = CGPoint(x: tabbarItemW*2.5, y: tabbarItamH*0.5)
        print(subviews.count)
        
        if subviews[2].isKindOfClass(NSClassFromString("UITabBarButton")!) {
            print("tabbaritem")
        }
        
        for i in 2..<(subviews.count-1) {
            var indexW = i - 2
            if i > 3 {
                indexW++
            }
            subviews[i].center = CGPoint(x: tabbarItemW*(CGFloat(indexW)+0.5), y: tabbarItamH*0.5)
        }
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
