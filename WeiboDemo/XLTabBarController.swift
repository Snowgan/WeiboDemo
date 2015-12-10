//
//  XLTabBarController.swift
//  WeiboDemo
//
//  Created by Jennifer on 17/11/15.
//  Copyright © 2015 Snowgan. All rights reserved.
//

import UIKit

class XLTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
        addAllChildVCs()
        let xlTabBar = XLTabBar()
        setValue(xlTabBar, forKey: "tabBar")
//        tabBar.backgroundImage = UIImage(named: "main_badge")
        print("tabbarc did load")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        print("tabbarc did appear")
    }
    
    override func viewWillAppear(animated: Bool) {
        print("tabbarc will appear")
    }
    
    override func viewWillLayoutSubviews() {
        print("tabbarc will layout")
    }
    
    override func viewDidLayoutSubviews() {
        print("tabbaec did layout")
    }
    
    func addAllChildVCs() {
        let home = XLHomeTableViewController(style: .Plain)
        addChildVC(home, title: "Home", imageName: "tabbar_home", selectedImageName: "tabbar_home_selected")
        
        let message = UITableViewController(style: .Plain)
        addChildVC(message, title: "Message", imageName: "tabbar_message_center", selectedImageName: "tabbar_message_center_selected")
        
        let discover = UITableViewController(style: .Plain)
        addChildVC(discover, title: "Discover", imageName: "tabbar_discover", selectedImageName: "tabbar_discover_selected")
        
        let profile = UITableViewController(style: .Plain)
        addChildVC(profile, title: "Me", imageName: "tabbar_profile", selectedImageName: "tabbar_profile_selected")
    }

    func addChildVC(childCV: UIViewController, title: String, imageName: String, selectedImageName: String) {
        let nav = UINavigationController(rootViewController: childCV)
        
        childCV.title = title
        
        if let homecv = childCV as? XLHomeTableViewController {
            homecv.setNaviBarTitle()
        }
        
        childCV.tabBarItem.image = UIImage(named: imageName)
        childCV.tabBarItem.selectedImage = UIImage(named: selectedImageName)
        
        addChildViewController(nav)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
