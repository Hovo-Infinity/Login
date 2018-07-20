//
//  UserDetailsViewController.swift
//  Login
//
//  Created by Hovhannes Stepanyan on 7/20/18.
//  Copyright © 2018 Hovhannes Stepanyan. All rights reserved.
//

import UIKit

class UserDetailsViewController: UIViewController {

    var manager: LoginProtocol?
    var user: UserModel!
    @IBOutlet private weak var firstNameLabel: UILabel!
    @IBOutlet private weak var lastNameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        profileImage.image = user.profileImage
        firstNameLabel.text = user.firstName
        lastNameLabel.text = user.lastName
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func logOut(_ sender: UIButton) {
        manager?.logOut()
        self.dismiss(animated: true)
    }

}
