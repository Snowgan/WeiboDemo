//
//  XLWelcomeView.swift
//  WeiboDemo
//
//  Created by Jennifer on 1/12/15.
//  Copyright © 2015 Snowgan. All rights reserved.
//

import UIKit

class XLWelcomeView: UIView {

    var profileImage: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //Profile Image
        let imageView = UIImageView()
        self.addSubview(imageView)
        self.profileImage = imageView
        
        //Welcome Label
        let lable = UILabel()
        lable.text = "Welcome Back"
        self.addSubview(lable)
        
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

}
