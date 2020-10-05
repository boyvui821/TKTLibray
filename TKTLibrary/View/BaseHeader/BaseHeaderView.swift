//
//  BaseHeaderView.swift
//  TikiTechLibrary
//
//  Created by Nguyen Hieu Trung on 9/8/20.
//  Copyright © 2020 NHTSOFT. All rights reserved.
//

import UIKit

public class BaseHeaderView: BaseView {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var leftContainer: UIView!
    @IBOutlet var leftImageView: UIImageView!
    @IBOutlet var leftButton: UIButton!
    
    @IBOutlet var rightContainer: UIView!
    @IBOutlet var rightImageView: UIImageView!
    @IBOutlet var rightButton: UIButton!
    
    var handleLeft: (() -> Void)?
    var handleRight: (() -> Void)?
    
    var heightIphoneX: CGFloat = 76
    
    var headerHeight:CGFloat = 0
    var headerHeightConstraint: NSLayoutConstraint?
    
    @IBInspectable
    public var titleColor: UIColor = UIColor.white{
        didSet {
            titleLabel.textColor = titleColor
        }
    }
    
    private func updateTitle(title: String, rightIcon: UIImage?){
        titleLabel.text = title
        if let icon = rightIcon{
            rightImageView.image = icon
            rightButton.isHidden = false
        }
    }
    
    public func setHidenLeft(isHiden:Bool){
        self.leftButton.isHidden = isHiden
        self.leftContainer.isHidden = isHiden
    }
    
    public func setHidenRight(isHiden:Bool){
        self.rightButton.isHidden = isHiden
        self.rightContainer.isHidden = isHiden
    }
    
    public func setupHeader(title:String, rightIcon: UIImage? ,backgroundColor: UIColor, heightConstraint: NSLayoutConstraint){
        self.updateTitle(title: title, rightIcon: rightIcon)
        
        if DeviceType.IS_IPHONE_X || DeviceType.IS_IPHONE_XR || DeviceType.IS_IPHONE_XSMAX {
            heightIphoneX = heightIphoneXDevice
            headerHeight = heightIphoneXDevice
        } else {
            heightIphoneX = heightIphoneOtherDevice
            headerHeight = heightIphoneOtherDevice
        }
        heightConstraint.constant = CGFloat(headerHeight)
        
        self.layer.masksToBounds = false
        self.backgroundColor = backgroundColor
    }
    
    
    @IBAction func onLeftPress(_ sender: UIButton) {
        self.handleLeft?()
    }
    
    @IBAction func onRightPress(_ sender: UIButton) {
        self.handleRight?()
    }
    
    public func onHandleLeft(handle: (()->Void)?){
        self.handleLeft = handle
    }
    
    public func onHandleRight(handle: (()->Void)?){
        self.handleRight = handle
    }
    
    public func setTitle(title:String){
        self.titleLabel.text = title
    }
    
    public func setIconTintColor(color:UIColor){
        leftImageView.tintColor = color
        rightImageView.tintColor = color
    }
}
