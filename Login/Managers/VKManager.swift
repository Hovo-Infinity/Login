
//
//  VKManager.swift
//  Login
//
//  Created by Hovhannes Stepanyan on 7/23/18.
//  Copyright © 2018 Hovhannes Stepanyan. All rights reserved.
//

import Foundation
import VK_ios_sdk

class VKManager: LoginProtocol {
    func logOut() {
        VKSdk.forceLogout()
    }
    
    func login(completion: @escaping ((UserModel?, Error?) -> Void)) {
        let scope = ["email", "audio", "photos"]
        VKSdk.wakeUpSession(scope) { (state, error) in
            switch state {
            case .authorized:
                let user = self.createCurrentUserModel()
                completion(user, nil)
                break
                
            case .error:
                completion(nil, error)
                break
                
            case .initialized:
                VKSdk.authorize(scope)
                VKDelegate.initializeShared()?.firstTimeAuth = { success in
                    if success {
                        let user = self.createCurrentUserModel()
                        completion(user, nil)
                    } else {
                        completion(nil, NSError(domain: "autherror", code: -1, userInfo: nil))
                    }
                }
                break
                
            default:
                break
            }
        }
    }
    
    private func createCurrentUserModel() -> UserModel {
        let user = UserModel()
        let vkUser = VKSdk.accessToken().localUser
        user.firstName = vkUser?.first_name
        user.lastName = vkUser?.last_name
        if let url = URL(string: (vkUser?.photo_100)!), let data = try? Data(contentsOf: url) {
            user.profileImage = UIImage(data: data)
        }
        return user
    }
}
