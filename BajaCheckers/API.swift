//
//  API.swift
//  RailsRequest
//
//  Created by Michael McChesney on 2/17/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

import Foundation

///////////
/////////// RAILS API
///////////

let API_URL = "https://baja-checkers.herokuapp.com/"

class APIRequest {
    
    class func requestWithOptions(options: [String:AnyObject], andCompletion completion: (responseInfo: [String:AnyObject]) -> ()) {
        
        var url = NSURL(string: API_URL + (options["endpoint"] as String))
        
        var request = NSMutableURLRequest(URL: url!)
        
        request.HTTPMethod = options["method"] as String

        ///// BODY
        
        let bodyInfo = options["body"] as [String:AnyObject]
        
        let requestData = NSJSONSerialization.dataWithJSONObject(bodyInfo, options: .allZeros, error: nil)
        
        let jsonString = NSString(data: requestData!, encoding: NSUTF8StringEncoding)
        
        let postLength = "\(jsonString!.length)"
        
        request.setValue(postLength, forHTTPHeaderField: "Content-Length")
        
        let postData = jsonString?.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: true)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.HTTPBody = postData
        
        ///// END BODY - now that it is setup, send the request
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in

            if error == nil {
                // do something with data
                
                if let json = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as? [String:AnyObject] {
                    
                    completion(responseInfo: json)
                    
                } else {
                    
                    println("no json")
                    
                }

                
            } else {
                println(error)
            }
   
        }
        
    }
    
}

    ///////////
    ///////////  USER CLASS / SINGLETON
    ///////////

private let _currentUser = User()

class User {
    
    var token: String? {
        didSet {
            // save the token when it's set
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject(token, forKey: "token")
            defaults.synchronize()
        }
    }
    
    init() {    // this fixes "no initializers" issue when creating the singleton. could do this or base class off NSObject.
        
        let defaults = NSUserDefaults.standardUserDefaults()
        token = defaults.objectForKey("token") as? String
        
    }
    
    class func currentUser() -> User { return _currentUser }
    
    
    ///////////
    /////////// SIGN UP USER
    ///////////
    
    func getUserToken(username: String, andEmail email: String, andPassword password: String, andCompletion completion: () -> ()) {
        
        var options: [String:AnyObject] = [
        
            "endpoint" : "users",
            "method" : "POST",
            "body" : [
            
                "user" : [ "username" : username, "email" : email, "password" : password ]
            
            ]
            
        ]
        
        APIRequest.requestWithOptions(options, andCompletion: { (responseInfo) -> () in
            // do something after request is done
            
            println(responseInfo)
            
            let dataInfo = responseInfo["user"] as [String:AnyObject]
            
            self.token = dataInfo["authentication_token"] as? String
            
        })
        
        completion()    // RUN THIS HERE OR IN THE REQUESTWITHOPTIONS METHOD ABOVE?
        
    }
    
    ///////////
    /////////// LOG IN USER
    ///////////
    
    func logInUser(email: String, andPassword password: String, andCompletion completion: () -> ()) {
        
        println(email, password)
        
        var options: [String:AnyObject] = [
            
            "endpoint" : "users/sign_in",
            "method" : "POST",
            "body" : [
                
                "user" : [ "email" : email, "password" : password ]
                
            ]
            
        ]
        
        APIRequest.requestWithOptions(options, andCompletion: { (responseInfo) -> () in
            // do something after request is done
            
            println(responseInfo)
            
            let dataInfo = responseInfo["user"] as [String:AnyObject]
            
            self.token = dataInfo["authentication_token"] as? String

        })
        
        completion()

    }
    
    
    ///////////
    /////////// JOIN NEW GAME
    ///////////
    
    // Join GAME METHOD
    func requestNewGame() {
        
        var options: [String:AnyObject] = [
            
            "endpoint" : "games",
            "method" : "PUT",
            "body" : [
                "auth_token" : token!
            ]
            
        ]
        
        APIRequest.requestWithOptions(options, andCompletion: { (responseInfo) -> () in
            // do something after request is done
            
            println(responseInfo)
            //create new game model and set data to response
            
        })
        
        
    }
    
    ///////////
    /////////// REQUEST GAME LIST
    ///////////
    
    func requestGameList() {
        
        var options: [String:AnyObject] = [
            
            "endpoint" : "games",
            "method" : "GET",
            "body" : [
                "auth_token" : token!
            ]
            
        ]
        
        APIRequest.requestWithOptions(options, andCompletion: { (responseInfo) -> () in
            // do something after request is done
            
            println(responseInfo)
            
            
            
        })
        
    }
    
}