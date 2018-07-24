//
//  GIDDelegate.swift
//  Login
//
//  Created by Hovhannes Stepanyan on 7/24/18.
//  Copyright © 2018 Hovhannes Stepanyan. All rights reserved.
//

import Foundation
import GoogleSignIn

class GIDDelegate: NSObject, GIDSignInDelegate, GIDSignInUIDelegate {
    
    // MARK: - GIDSignInDelegate
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        completion?(user, error)
    }
    
    // MARK: - GIDSignInUIDelegate
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        UIViewController.topViewController()?.present(viewController, animated: true)
    }
    
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        
    }
    
    private static var shared: GIDDelegate? = nil
    
    public var completion: ((GIDGoogleUser?, Error?) -> Void)?
    
    public static func initializeShared() -> GIDDelegate? {
        if shared == nil {
            shared = GIDDelegate()
        }
        return shared
    }
    
    private override init() {
        completion = nil
        super.init()
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
    }
}
