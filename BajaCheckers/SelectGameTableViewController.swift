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
    
    var gameList: [GameModel]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // check for existing token - move to VIEWDIDLOAD or ViewdidAppear?
        if let token = User.currentUser().token {
            println("User exists and is logged in with auth token: \(token)")
            
        } else {
            
            // go to LogInViewController
            if let loginVC = storyboard?.instantiateViewControllerWithIdentifier("loginVC") as? LoginViewController {
                navigationController?.presentViewController(loginVC, animated: false, completion: nil)
            }
            
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        updateGameList()
    }
    
    ////////
    //////// UPDATE GAME LIST FROM SINGLETON
    ////////
    
    func updateGameList() {
        
        if let token = User.currentUser().token {
            
            // load game list
            User.currentUser().requestGameList({ () -> () in
                
                self.gameList = DataModel.mainData().allGames
                println("gamelist is: \(self.gameList)")
                
            })
            
        }
        
    }
    
    ////////
    //////// SET UP MENU ITEMS / SECTIONS.  DO WE NEED THIS?
    ////////
    
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
                
            addSection("Your Move", item: [""])
            addSection("Their Move", item: [""])
            addSection("Past Games", item: [""])
            addSection("Leaderboard", item: [""])

        }
        
    }
    
    ////////
    //////// CREATE NEW GAME AND PUSH TO GAMEVIEWCONTROLLER
    ////////
    
    @IBAction func createNewGame(sender: AnyObject) {
        
        User.currentUser().requestNewGame { () -> () in
         
            self.tableView.reloadData() // needed?
            if let gameplayVC = self.storyboard?.instantiateViewControllerWithIdentifier("gameplayVC") as? GameViewController {
                self.navigationController?.presentViewController(gameplayVC, animated: false, completion: nil)
            }
            
        }
        
    }
    

    
    ////////
    //////// NUMBER OF CELLS AND SECTIONS
    ////////


    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return menuItems.sections.count
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return menuItems.items[section].count
        
    }
    

    ////////
    //////// SET UP CELLS
    ////////
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as GameTableViewCell
    

//        println(gameList)
//        cell.player2 =
        

        return cell
    
    }
    
    ////////
    //////// LISTEN FOR CELLS BEING SELECTED
    ////////
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let row = indexPath.row
        let section = indexPath.section
        let select = menuItems.items[section][row] + " " + menuItems.sections[section]
        //navigationItem.title = select
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        
//        let gameVC = storyboard?.instantiateViewControllerWithIdentifier("gameVC")
//        presentViewController(gameVC, animated: true, completion: nil)
        

    }
    
    ////////
    //////// SET UP HEADERS FOR SECTIONS
    ////////
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return menuItems.sections[section]
        
    }
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        let headerView = view as UITableViewHeaderFooterView
        headerView.textLabel.textColor = UIColor.whiteColor()
        let font = UIFont(name: "HelveticaNeue-Regular", size: 16.0)
        headerView.textLabel.font = font?
        headerView.contentView.backgroundColor = UIColor(red:0.15, green:0.49, blue:0.6, alpha:0.4)

    
    }
    
}
