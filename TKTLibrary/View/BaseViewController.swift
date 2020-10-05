//
//  BaseViewController.swift
//  TKTLibrary
//
//  Created by Nguyen Hieu Trung on 10/1/20.
//  Copyright © 2020 NHTSOFT. All rights reserved.
//

import UIKit

public class BaseViewController: UIViewController {
    
    var loadingView: UIView?
    var indicator: UIActivityIndicatorView?
    public override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func initLoadingView() -> UIView{
        indicator = UIActivityIndicatorView()
        indicator?.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        indicator?.center = self.view.center
        indicator?.hidesWhenStopped = true
        indicator?.style =
            UIActivityIndicatorView.Style.whiteLarge
        return indicator!
    }
    
    func showLoading(){
        loadingView = initLoadingView()
        self.view.isUserInteractionEnabled = false
        if let indicator = loadingView as? UIActivityIndicatorView{
            indicator.color = UIColor.black
            indicator.startAnimating()
            self.view.addSubview(indicator)
        }
    }
    
    func hideLoading(){
        indicator?.removeFromSuperview()
        self.view.isUserInteractionEnabled = true
    }
    
}
