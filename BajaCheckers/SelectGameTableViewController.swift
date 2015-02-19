//
//  SelectGameTableViewController.swift
//  BajaCheckers
//
//  Created by Michael McChesney on 2/18/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

import UIKit

class SelectGameTableViewController: UITableViewController {
    
    let menuItems = GameMenuItems()
    
    class MenuItems: NSObject {
        var sections:[String] = []
        var items:[[String]] = []
        
        func addSection(section:String,item:[String]){
            sections = sections + [section]
            items = items + [item]
        }
    }
    
class GameMenuItems: MenuItems {
        override init() {
            super.init()
            
            addSection("Your Move", item:   ["Jim","Bob","Max","Andy","Greg"])
            addSection("Their Move", item: ["Jim","Bob"]) 
            addSection("Past Games", item: ["Jim","Bob","Max","Andy","Greg"])
            addSection("Leaderboard", item: ["Jim","Bob","Max","Andy","Greg"])
    }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        // check for existing token - move to VIEWDIDLOAD or ViewdidAppear?
        if let token = User.currentUser().token {
            println("User exists and is logged in with auth token: \(token)")
            
        } else {
            
            // go to SelectGameViewController
            if let loginVC = storyboard?.instantiateViewControllerWithIdentifier("loginVC") as? LoginViewController {
                navigationController?.presentViewController(loginVC, animated: false, completion: nil)
            }
            
        }
        
        self.tableView.backgroundColor = UIColor.redColor()

    }


    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
            return menuItems.sections.count
        }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return menuItems.items[section].count
        }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as GameTableViewCell
            cell.textLabel?.text = menuItems.items[indexPath.section][indexPath.row]
            return cell
        }
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return menuItems.sections[section]
        }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            let row = indexPath.row
            let section = indexPath.section
            let select = menuItems.items[section][row] + " " + menuItems.sections[section]
            //navigationItem.title = select
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
    
    }
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let headerView = view as UITableViewHeaderFooterView
        headerView.textLabel.textColor = UIColor.blackColor()
        let font = UIFont(name: "AvenirNextCondensed-HeavyItalic", size: 23.0)
        headerView.textLabel.font = font?
        headerView.contentView.backgroundColor = UIColor.redColor()
    
}
}
