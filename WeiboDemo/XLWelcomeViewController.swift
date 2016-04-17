//
//  XLWelcomeViewController.swift
//  WeiboDemo
//
//  Created by Jennifer on 29/11/15.
//  Copyright © 2015 Snowgan. All rights reserved.
//

import UIKit
import Kingfisher

class XLWelcomeViewController: UIViewController {
    
    var bgImageView: UIImageView!
    var profileView: UIView!
    var welcLabel: UILabel!
    
    // MARK: - Life Cycle
    
    override func loadView() {
        let backgroundView = UIView(frame: windowFrame)
        backgroundView.backgroundColor = bgColor
        view = backgroundView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(didLogin), name: WBTokenDidSetNotification, object: nil)
        
        if NSUserDefaults.standardUserDefaults().objectForKey("accessToken") == nil {
            let request = WBAuthorizeRequest.request() as! WBAuthorizeRequest
            request.redirectURI = "https://api.weibo.com/oauth2/default.html"
            request.scope = "all"
            WeiboSDK.sendRequest(request)
        } else {
            print(NSUserDefaults.standardUserDefaults().objectForKey("accessToken"))
            didLogin()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Layer delegate method
//    override func drawLayer(layer: CALayer, inContext ctx: CGContext) {
//        CGContextSaveGState(ctx)
//        
//        let im = UIImage(named: "FaceQ")
//        CGContextDrawImage(ctx, CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0), im?.CGImage)
//        
//        CGContextRestoreGState(ctx)
//    }
    
    // MARK: - UI Setup And Animation
    
    func setupSubviews() {
        
        // Background Image View
        bgImageView = UIImageView(frame: windowFrame)
        bgImageView.image = UIImage(named: "Welcome")
        self.view.addSubview(bgImageView)
        
        // Profile Image View With Corner Radius
        profileView = UIView()
        profileView.bounds.size = CGSize(width: 100.0, height: 100.0)
        profileView.center = CGPoint(x: windowCenterX, y: 200)
        let profileLayer = profileView.layer
        profileLayer.cornerRadius = profileView.bounds.width/2
        profileLayer.masksToBounds = true
        profileView.alpha = 0.0
        self.view.addSubview(profileView)
        
        // Welcome Text Label
        let welcText: NSString = "Welcome Back"
        let welcFont = UIFont(name: "Chalkduster", size: 18)
        let textSize = welcText.sizeWithAttributes([NSFontAttributeName: welcFont!])
        welcLabel = UILabel(frame: CGRect(origin: CGPoint(x: windowCenterX-textSize.width/2, y: profileView.center.y+10), size: textSize))
        welcLabel.font = welcFont
        welcLabel.text = welcText as String
        welcLabel.alpha = 0.0
        self.view.addSubview(welcLabel)
        
    }
    
    func setupView(view: UIView, withImageURLString urlString: String) {
        
        KingfisherManager.sharedManager.retrieveImageWithURL(NSURL(string: urlString)!, optionsInfo: nil, progressBlock: nil) { [unowned self] (image, error, cacheType, imageURL) -> () in
            
            if image != nil {
                view.layer.contents = image!.CGImage
                
                self.showView()
            }
        }
        
    }
    
    func showView() {
                
        UIView.transitionWithView(self.bgImageView, duration: 0.5, options: .TransitionCrossDissolve, animations: {
            self.bgImageView.hidden = true
            }, completion: nil)
        
        
        UIView.animateWithDuration(1.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: [], animations: {
            self.profileView.alpha = 1.0
            self.profileView.center.y -= 50
            }, completion: nil)
        
        UIView.animateWithDuration(1.0, delay: 1.0, options: [.CurveEaseIn], animations: {
            self.welcLabel.alpha = 1.0
            }, completion: nil)
        
        // 
        delay(seconds: 3.0) {
            let window = UIApplication.sharedApplication().keyWindow
            window?.rootViewController = XLTabBarController()
        }
    }
    
    // MARK: - User Auth
    
    func didLogin() {
        let urlString = "https://api.weibo.com/2/users/show.json"
        var queryDic = [String: AnyObject]()
        let userDefaults = NSUserDefaults.standardUserDefaults()
        queryDic["access_token"] = userDefaults.objectForKey("accessToken")!
        queryDic["uid"] = userDefaults.objectForKey("userID")!
        XLWeiboAPI.sharedWeiboAPI.requestWithURL(urlString, params: queryDic) { (json) -> () in
            print("\(json["avatar_large"])")
            userDefaults.setObject(json["name"].string!, forKey: "userName")
            self.setupView(self.profileView, withImageURLString: json["avatar_large"].string!)
        }
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

}
