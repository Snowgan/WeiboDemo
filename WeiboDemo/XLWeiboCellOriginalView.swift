//
//  XLWeiboCellOriginalView.swift
//  WeiboDemo
//
//  Created by Jennifer on 29/11/15.
//  Copyright © 2015 Snowgan. All rights reserved.
//

import UIKit



class XLWeiboCellOriginalView: UIView {

    var profileImage: UIImageView!
    var nameLabel: UILabel!
    var sourceLable: UILabel!
    var textView: UITextView!
    var rightTopButton: XLWeiboCellRightTopButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
        let textV = UITextView()
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
    
    func setupViewFrame() {
        
        profileImage.frame = CGRect(x: kWeiboCellMargin, y: kWeiboCellMargin, width: 30, height: 30)
        
        
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
