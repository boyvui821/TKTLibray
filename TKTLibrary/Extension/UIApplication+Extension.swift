//
//  UIApplication+Extension.swift
//  TKTLibrary
//
//  Created by Nguyen Hieu Trung on 9/29/20.
//  Copyright © 2020 NHTSOFT. All rights reserved.
//

import UIKit

extension UIApplication{
    class func topViewController(viewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = viewController as? UINavigationController {
            return topViewController(viewController: nav.visibleViewController)
        }
        if let tab = viewController as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(viewController: selected)
            }
        }
        if let presented = viewController?.presentedViewController {
            return topViewController(viewController: presented)
        }
        return viewController
    }
}
