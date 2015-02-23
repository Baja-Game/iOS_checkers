//
//  LoginViewController.swift
//  BajaCheckers
//
//  Created by Michael McChesney on 2/18/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var logInButton: CustomButton!
    @IBOutlet weak var signUpButton: CustomButton!
    @IBOutlet weak var displayLogInLink: UIButton!
    @IBOutlet weak var usernameLine: UIView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var checkmarkImage: UIImageView!
    @IBOutlet weak var logoTextLabel: UILabel!
    @IBOutlet weak var containerCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var logInLinkConstraint: NSLayoutConstraint!
    
    var savedConstraintConstant: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        logInButton.hidden = true
        
        ////// move fields with keyboard
        
        savedConstraintConstant = self.containerCenterConstraint.constant
        
        NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardWillShowNotification, object: nil, queue: NSOperationQueue.mainQueue()) { (notification: NSNotification!) -> Void in
            
            if let kbSize = notification.userInfo?[UIKeyboardFrameEndUserInfoKey]?.CGRectValue().size {
                
                self.containerCenterConstraint.constant = kbSize.height / 2.2
//                self.containerBottomConstraint.constant = 0
                
                self.checkmarkImage.alpha = 0.05     // fade out the logo image when keyboard rises
                self.logoTextLabel.alpha = 0.05
                
                // used to animate constraint
                self.view.layoutIfNeeded()
                
            }
        }
        
        NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardWillHideNotification, object: nil, queue: NSOperationQueue.mainQueue()) { (notification) -> Void in
            
            self.containerCenterConstraint.constant = self.savedConstraintConstant
            
            self.checkmarkImage.alpha = 1.0
            self.logoTextLabel.alpha = 1.0
            
            // used to animate constraint
            self.view.layoutIfNeeded()
            
        }
        
        
        
        
    }
    
    @IBAction func signUpUser(sender: AnyObject) {
        
        
        var fieldValues: [String] = [emailTextField.text, passwordTextField.text, usernameTextField.text]
        
        // check if all fields are filled in
        if find(fieldValues, "") != nil {
            
            // all fields are not filled in, present error
            var alertViewController = UIAlertController(title: "Sign Up Error", message: "Please fill in all fields.", preferredStyle: UIAlertControllerStyle.Alert)
            
            var defaultAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
            
            alertViewController.addAction(defaultAction)
            
            presentViewController(alertViewController, animated: true, completion: nil)
            
        } else {
            
            // all fields are filled in, sign up user (DO WE NEED TO CHECK FOR EXISTING USER? / HOW DO WE HANDLE ERRORS?)
            println("Sign up btn pressed, getting user token...")

            User.currentUser().getUserToken(fieldValues[2], andEmail: fieldValues[0], andPassword: fieldValues[1], andCompletion: { () -> () in
                
                // dismiss view controller when finished
                self.dismissViewControllerAnimated(true, completion: nil)
                
            })

            
        }
        
    }
    
    var logInHidden: Bool = true
    @IBAction func displayLogIn(sender: AnyObject) {
        // hide the username textfield, hide sign up, unhide log in, move items up

        // toggle
        if logInHidden {
            // Show log in fields and button
            logInHidden = false
            
            self.logInLinkConstraint.constant = 73
            
            usernameTextField.hidden = true
            usernameLine.hidden = true
            usernameLabel.hidden = true
            signUpButton.hidden = true
            logInButton.hidden = false
            
            displayLogInLink.setTitle("or, Sign Up", forState: .Normal)
            
        } else {
            // Show Sign up fields and button
            logInHidden = true
            
            self.logInLinkConstraint.constant = 112
            
            usernameTextField.hidden = false
            usernameLine.hidden = false
            usernameLabel.hidden = false
            signUpButton.hidden = false
            logInButton.hidden = true
            
            displayLogInLink.setTitle("or, Log In", forState: .Normal)
            
        }
        
    }
    
    @IBAction func logInUser(sender: AnyObject) {
        // log in user

        
        var fieldValues: [String] = [emailTextField.text, passwordTextField.text]
        
        // check if all fields are filled in
        if find(fieldValues, "") != nil {
            
            // all fields are not filled in, present error
            var alertViewController = UIAlertController(title: "Log In Error", message: "Please fill in all fields.", preferredStyle: UIAlertControllerStyle.Alert)
            
            var defaultAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
            
            alertViewController.addAction(defaultAction)
            
            presentViewController(alertViewController, animated: true, completion: nil)
            
        } else {
            
            // all fields are filled in, sign up user (DO WE NEED TO CHECK FOR EXISTING USER?)
            println("Login btn pressed, attempting to login user...")
            
            User.currentUser().logInUser(fieldValues[0], andPassword: fieldValues[1], andCompletion: { () -> () in
                
                
                // dismiss view controller when finished
                self.dismissViewControllerAnimated(true, completion: nil)
                
            })
            
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
