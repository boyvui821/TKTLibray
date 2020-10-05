//
//  UIAlertViewController+Extension.swift
//  TKTLibrary
//
//  Created by Nguyen Hieu Trung on 9/29/20.
//  Copyright © 2020 NHTSOFT. All rights reserved.
//

import UIKit

extension UIAlertController{
    
    static func show(title:String = "Message", message:String,handleComplete:@escaping ((_ buttonIndex:Int)->())){
        let topViewController = UIApplication.topViewController()
    
        
        let alert = self.init(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel) { (action) in
//            topViewController?.dismiss(animated: <#T##Bool#>, completion: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
        }
        alert.addAction(action)
        topViewController?.present(alert, animated: true, completion: nil)
    }
}
