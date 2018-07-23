//
//  ViewController.swift
//  Login
//
//  Created by Hovhannes Stepanyan on 7/20/18.
//  Copyright © 2018 Hovhannes Stepanyan. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class ViewController: UIViewController {
    
    private var loginManager: LoginProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func login() {
        loginManager.login { (user, error) in
            if let err = error {
                print(err.localizedDescription)
            } else {
                let userVC: UserDetailsViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "UserDetailsViewController") as! UserDetailsViewController
                userVC.user = user!
                userVC.manager = self.loginManager
                self.present(userVC, animated: true)
            }
        }
    }

    @IBAction func FBLogin(_ sender: UIButton) {
        loginManager = FBManager()
        login()
    }
    
    @IBAction func FIRLogin() {
        loginManager = FirabaseManager()
        login()
    }
    
    @IBAction func VKLogin() {
        loginManager = VKManager()
        login()
    }
    
}

