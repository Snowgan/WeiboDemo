//
//  XLHomeTableViewController.swift
//  WeiboDemo
//
//  Created by Jennifer on 29/11/15.
//  Copyright © 2015 Snowgan. All rights reserved.
//

import UIKit

class XLHomeTableViewController: UITableViewController {
    
//    var isLogin = false
    
    var homeStatuses = XLMultiStatus()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(normalImage: UIImage(named: "navigationbar_friendsearch"), highLightedImage: UIImage(named: "navigationbar_friendsearch_highlighted"), target: self, action: "")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(normalImage: UIImage(named: "navigationbar_pop"), highLightedImage: UIImage(named: "navigationbar_pop_highlighted"), target: self, action: "")
        
        self.tableView.registerClass(XLWeiboCell.self, forCellReuseIdentifier: kXLHomeCellIdentifier)
        
        self.tableView.separatorStyle = .None
//        self.tableView.separatorInset = UIEdgeInsets(top: 5, left: 10, bottom: 0, right: 10)
        
        self.tableView.backgroundColor = bgColor
        
//        if isLogin {
//            
//        }
        
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        var queryDic = [String: AnyObject]()
        queryDic["access_token"] = NSUserDefaults.standardUserDefaults().objectForKey("accessToken")!
        XLWeiboAPI.sharedWeiboAPI.requestWithURL(urlString, params: queryDic) { (json) -> () in
            print("\(json)")
            self.homeStatuses = XLMultiStatus(withJSON: json)
//            print(self.homeStatuses.statusArr)
            
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData()
            })
        }
        
    }

    func setNaviBarTitle() {
        self.navigationItem.title = "Snowgan"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

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
//        print(cellH)
        return cellH + 31 + 7
    }
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

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
