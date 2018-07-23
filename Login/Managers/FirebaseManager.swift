//
//  FirebaseManager.swift
//  Login
//
//  Created by Hovhannes Stepanyan on 7/20/18.
//  Copyright © 2018 Hovhannes Stepanyan. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

class FirabaseManager: LoginProtocol {
    func login(completion: @escaping ((UserModel?, Error?) -> Void)) {
        let loginVC: CustomLoginViewController = UIViewController.loadFromStoyBoard(named: "Main")
        loginVC.provider = "Firebase"
        loginVC.loginComplition = { result, error in
            if let err = error {
                completion(nil, err)
            } else {
                let firUser = (result as! AuthDataResult).user
                let user = UserModel()
                user.firstName = firUser.displayName
                user.profileImage = UIImage(data: try! Data.init(contentsOf: firUser.photoURL ?? URL(string: "")!))
                completion(user, nil)
            }
            
        }
        UIViewController.topViewController()?.present(loginVC, animated: true)
    }
    
    func logOut() {
        let firebase = Auth.auth()
        do {
            try firebase.signOut()
        } catch {
            print(error.localizedDescription)
        }
    }
}
