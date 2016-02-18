//
//  XLWeiboPicView.swift
//  WeiboDemo
//
//  Created by Jennifer on 14/2/16.
//  Copyright © 2016 Snowgan. All rights reserved.
//

import UIKit
import Kingfisher

class XLWeiboPicView: UIImageView {

    var url: String! {
        didSet {
            self.kf_setImageWithURL(NSURL(string: url)!, placeholderImage: UIImage(named: "timeline_image_placeholder"), optionsInfo: nil) { [weak self] (image, error, cacheType, imageURL) -> () in
                self?.contentMode = .Center
                self?.clipsToBounds = true
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
