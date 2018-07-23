//
//  UIViewControllerExtension.swift
//  Login
//
//  Created by Hovhannes Stepanyan on 7/20/18.
//  Copyright © 2018 Hovhannes Stepanyan. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    class func topViewController() -> UIViewController? {
        var top = UIApplication.shared.keyWindow?.rootViewController
        while true {
            if let presented = top?.presentedViewController {
                top = presented
            } else if let nav = top as? UINavigationController {
                top = nav.visibleViewController
            } else if let tab = top as? UITabBarController {
                top = tab.selectedViewController
            } else {
                break
            }
        }
        return top
    }
    
    class func loadFromStoyBoard<T>(named: String, in bundle: Bundle? = nil) -> T {
        let id = String(describing: T.self).components(separatedBy: ".").last
        let storyboard = UIStoryboard(name: named, bundle: bundle)
        return storyboard.instantiateViewController(withIdentifier: id!) as! T
    }
}
