//
//  CustomLoginViewController.swift
//  Login
//
//  Created by Hovhannes Stepanyan on 7/20/18.
//  Copyright © 2018 Hovhannes Stepanyan. All rights reserved.
//

import UIKit
import FirebaseAuth

class CustomLoginViewController: UIViewController {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    var provider: String!
    var loginComplition: ((Any?, Error?) -> Void)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = String(format: "Login With %@", provider)
        // Do any additional setup after loading the view.
    }

    @IBAction func login(_ sender: UIButton) {
        if emailTextField.text?.isEmpty == true || passwordTextField.text?.isEmpty == true {
            return
        } else {
            let email = emailTextField.text!
            let password = passwordTextField.text!
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                self.loginComplition(result, error)
            }
        }
    }
}
