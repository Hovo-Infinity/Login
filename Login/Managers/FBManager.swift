//
//  FBManager.swift
//  Login
//
//  Created by Hovhannes Stepanyan on 7/20/18.
//  Copyright © 2018 Hovhannes Stepanyan. All rights reserved.
//

import Foundation
import FBSDKLoginKit

class FBManager: LoginProtocol {
    var manager = FBSDKLoginManager()
    func login(completion: @escaping ((UserModel?, Error?) -> Void)) {
        manager.logIn(withReadPermissions: ["email", "user_gender"], from: nil) { (result, error) in
            FBSDKGraphRequest.init(graphPath: "me", parameters: ["fields": "picture, short_name, first_name, last_name, email"]).start(completionHandler: { (connection, result, error) in
                if let err = error {
                    completion(nil, err)
                } else {
                    let resultDict = result as! NSDictionary
                    let user = UserModel()
                    user.email = resultDict["email"] as? String
                    user.firstName = resultDict["first_name"] as? String
                    user.lastName = resultDict["last_name"] as? String
                    if let pictureDict = (resultDict["picture"] as? NSDictionary) {
                        if let picture = pictureDict["data"] as? NSDictionary {
                            let url = URL(string: picture["url"] as! String)
                            user.profileImage = UIImage(data: try! Data.init(contentsOf: url!))
                        }
                    }
                    completion(user, nil)
                }
            })
        }
    }
    
    func logOut() {
        manager.logOut()
    }
}
