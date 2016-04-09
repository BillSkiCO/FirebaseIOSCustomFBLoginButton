//
//  FacebookLogin.swift
//  Docense
//
//  Created by Bill Golembieski on 4/9/16.
//  Email: BillGolembieski@projectu23.com
//  Copyright © 2016 Bill Golembieski. All rights reserved.
//
//  Provides a function facebookLoginButton() that will log user into your app
//  using Firebase OAuth

import Foundation
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase

//Get Current View Controller to satisfy FBSDKLoginManager.logInWithReadPermissions

extension UIApplication {
    class func topViewController(vc: UIViewController? = UIApplication.sharedApplication().keyWindow?.rootViewController) -> UIViewController? {
        
        if let nav = vc as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        
        if let tab = vc as? UITabBarController {
            let moreNavigationController = tab.moreNavigationController
            
            if let top = moreNavigationController.topViewController where top.view.window != nil {
                return topViewController(top)
            } else if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        
        if let presented = vc?.presentedViewController {
            return topViewController(presented)
        }
        
        return vc
    }
}

func facebookLoginButton(){
    
    let vc = UIApplication.topViewController()
    
    let facebookLogin = FBSDKLoginManager()
    
    /*  To set permissions for your app. Full list can be found here.
    https://developers.facebook.com/docs/facebook-login/permissions
    */
    
    facebookLogin.logInWithReadPermissions(["email"], fromViewController: vc) { (facebookResult, facebookError) -> Void in
    
        if facebookError != nil
        {
            print("Facebook login failed. Error \(facebookError)")
        }
        else if facebookResult.isCancelled
        {
            print("Facebook login cancelled")
        }
        else
        {
            let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
        
            FIREBASE_REF.authWithOAuthProvider("facebook", token: accessToken, withCompletionBlock: { (error, authData) -> Void in
            
                if error != nil
                {
                    print("Login failed. \(error)")
                }
                else
                {
                    //If account doesn't exist
                    NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: "uid")
                    print("Logged in! \(authData.uid)")
                }
            })
        }
}
}
