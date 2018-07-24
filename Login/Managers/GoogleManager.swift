//
//  GoogleManager.swift
//  Login
//
//  Created by Hovhannes Stepanyan on 7/24/18.
//  Copyright © 2018 Hovhannes Stepanyan. All rights reserved.
//

import Foundation
import GoogleSignIn

class GoogleManager: LoginProtocol {
    func login(completion: @escaping ((UserModel?, Error?) -> Void)) {
        GIDSignIn.sharedInstance().signIn()
        GIDDelegate.initializeShared()?.completion = { gidUser, error in
            if error != nil {
                completion(nil, error)
            } else {
                let model = UserModel()
                model.email = gidUser?.profile.email
                model.firstName = gidUser?.profile.name
                model.lastName = gidUser?.profile.familyName
                if gidUser?.profile.hasImage == true {
                    if let url = gidUser?.profile.imageURL(withDimension: 100),
                        let data = try? Data(contentsOf: url) {
                        model.profileImage = UIImage(data: data)
                    }
                }
                completion(model, nil)
            }
        }
    }
    
    func logOut() {
        GIDSignIn.sharedInstance().signOut()
    }
}
