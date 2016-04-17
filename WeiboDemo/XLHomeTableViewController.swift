//
//  XLHomeTableViewController.swift
//  WeiboDemo
//
//  Created by Jennifer on 29/11/15.
//  Copyright © 2015 Snowgan. All rights reserved.
//

import UIKit
import XLRefreshSwift

class XLHomeTableViewController: UITableViewController {
    
//    var isLogin = false
    
    var homeStatuses = XLMultiStatus()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(normalImage: UIImage(named: "navigationbar_friendsearch"), highLightedImage: UIImage(named: "navigationbar_friendsearch_highlighted"), target: self, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(normalImage: UIImage(named: "navigationbar_pop"), highLightedImage: UIImage(named: "navigationbar_pop_highlighted"), target: self, action: nil)
        navigationItem.title = NSUserDefaults.standardUserDefaults().objectForKey("userName") as? String
        
        tableView.registerClass(XLWeiboCell.self, forCellReuseIdentifier: kXLHomeCellIdentifier)
        
        tableView.separatorStyle = .None
//        self.tableView.separatorInset = UIEdgeInsets(top: 5, left: 10, bottom: 0, right: 10)
        
        tableView.backgroundColor = bgColor
        
        setupRefresh()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return homeStatuses.statusArr.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kXLHomeCellIdentifier, forIndexPath: indexPath) as! XLWeiboCell
        let row = indexPath.row
        cell.status = homeStatuses.statusArr[row]
        cell.layout = homeStatuses.statusLayoutArr[row]
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let cellH = homeStatuses.statusLayoutArr[indexPath.row].height
        return cellH + 31 + 7
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func setupRefresh() {
        
        tableView.xlheader = XLRefreshHeader(action: {
            self.refreshStatuses(true)
        })
        
        tableView.xlfooter = XLRefreshFooter(action: {
            self.loadMore()
        })
        
        refreshStatuses(false)
        
    }
    
    func refreshStatuses(hasHeader: Bool) {
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        var queryDic = [String: AnyObject]()
        queryDic["access_token"] = NSUserDefaults.standardUserDefaults().objectForKey("accessToken")!
        XLWeiboAPI.sharedWeiboAPI.requestWithURL(urlString, params: queryDic) { [unowned self] (json) -> () in
            print("\(json)")
            self.homeStatuses = XLMultiStatus(withJSON: json)
            
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData()
                if hasHeader {
                    self.tableView.endHeaderRefresh()
                }
            })
        }
    }
    
    func loadMore() {
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        var queryDic = [String: AnyObject]()
        queryDic["access_token"] = NSUserDefaults.standardUserDefaults().objectForKey("accessToken")!
        queryDic["max_id"] = homeStatuses.lastStatusID
        XLWeiboAPI.sharedWeiboAPI.requestWithURL(urlString, params: queryDic) { [unowned self] (json) -> () in
            print("\(json)")
            let loadStatuses = XLMultiStatus(withJSON: json)
            loadStatuses.statusArr.removeAtIndex(0)
            loadStatuses.statusLayoutArr.removeAtIndex(0)
            
            self.homeStatuses.lastStatusID = loadStatuses.lastStatusID
            self.homeStatuses.statusArr.appendContentsOf(loadStatuses.statusArr)
            self.homeStatuses.statusLayoutArr.appendContentsOf(loadStatuses.statusLayoutArr)
            
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData()
                self.tableView.endFooterRefresh()
            })
        }
    }
}

extension UIBarButtonItem {
    
    convenience init(normalImage: UIImage?, highLightedImage: UIImage?, target: AnyObject?, action: Selector) {
        let barButton = UIButton()
        barButton.setImage(normalImage, forState: .Normal)
        barButton.setImage(highLightedImage, forState: .Highlighted)
        barButton.bounds.size = barButton.currentImage!.size
        barButton.addTarget(target, action: action, forControlEvents: .TouchUpInside)
        self.init(customView: barButton)
    }
    
}
