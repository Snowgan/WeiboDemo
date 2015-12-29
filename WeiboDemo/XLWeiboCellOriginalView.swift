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
    var textView: UITextView!
    var rightTopButton: XLWeiboCellRightTopButton!
    
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
        let textV = UITextView()
        textV.editable = false
        textV.scrollEnabled = false
        textV.textContainerInset = UIEdgeInsetsZero
        textV.textContainer.lineFragmentPadding = 0
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
        
        textView.text = status.text
        
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
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
