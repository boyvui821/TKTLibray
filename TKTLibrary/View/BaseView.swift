//
//  BaseView.swift
//  TKTLibrary
//
//  Created by Nguyen Hieu Trung on 9/8/20.
//  Copyright © 2020 NHTSOFT. All rights reserved.
//

import UIKit

public class BaseView: UIView {
    var contentView: UIView?
    var indicatorView:UIView!
    var activityIndicator:UIActivityIndicatorView!
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        xibSetup()
//    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }

    //for use this view in ui
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }

    func xibSetup() {
        contentView = loadViewFromNib()
        contentView?.frame = bounds
        contentView?.autoresizingMask =
            [.flexibleWidth, .flexibleHeight]
        addSubview(contentView!)    }
    
    func loadViewFromNib() -> UIView? {
        // guard let nibName = nibName else { return nil }
        let className = String(describing: self.classForCoder)
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: className, bundle: bundle)
        return nib.instantiate(
            withOwner: self,
            options: nil).first as? UIView
    }
    
//    func hideKeyboardWhenTappedAround() {
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
//        tap.cancelsTouchesInView = false
//        self.addGestureRecognizer(tap)
//    }
//
//    @objc func dismissKeyboard() {
//        self.endEditing(true)
//    }
    
}

