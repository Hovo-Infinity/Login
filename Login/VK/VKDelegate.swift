//
//  VKDelegate.swift
//  Login
//
//  Created by Hovhannes Stepanyan on 7/23/18.
//  Copyright © 2018 Hovhannes Stepanyan. All rights reserved.
//

import Foundation
import VK_ios_sdk

class VKDelegate: NSObject, VKSdkDelegate, VKSdkUIDelegate {
    
    private static var delegate: VKDelegate? = nil
    
    internal var firstTimeAuth: ((Bool) -> Void)? = nil
    private var success = false
    
    private override init() {
        super.init()
        if (VKSdk.initialized()) {
            VKSdk.instance().register(self)
            VKSdk.instance().uiDelegate = self
        }
    }
    
    class func initializeShared() -> VKDelegate? {
        if delegate == nil {
            delegate = VKDelegate()
        }
        return delegate
    }
    
    // MARK: - VKSdkDelegate
    func vkSdkUserAuthorizationFailed() {
        
    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        success = result.error == nil
    }
    
    // MARK: - VKSdkUIDelegate
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        UIViewController.topViewController()?.present(controller, animated: true)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        let captchaVC = VKCaptchaViewController.captchaControllerWithError(captchaError)
        
        UIViewController.topViewController()?.present(captchaVC!, animated: true)
    }
    
    func vkSdkDidDismiss(_ controller: UIViewController!) {
        firstTimeAuth?(success)
    }
}
