//
//  LoginProtocol.swift
//  Login
//
//  Created by Hovhannes Stepanyan on 7/20/18.
//  Copyright © 2018 Hovhannes Stepanyan. All rights reserved.
//

import Foundation

protocol LoginProtocol {
    func login(completion: (@escaping (_ user: UserModel?, _ error: Error?) -> Void))
    func logOut() -> Void
}
