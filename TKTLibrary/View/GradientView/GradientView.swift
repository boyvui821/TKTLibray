//
//  GradientView.swift
//  TKTLibrary
//
//  Created by Nguyen Hieu Trung on 9/13/20.
//  Copyright © 2020 NHTSOFT. All rights reserved.
//

import UIKit

class GradientView: UIView {
    var gradientLayer: CAGradientLayer?
    
    override open class var layerClass: AnyClass {
        return CAGradientLayer.classForCoder()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        gradientLayer = layer as? CAGradientLayer
        gradientLayer?.colors = [UIColor.black.cgColor, UIColor.white.cgColor]
        gradientLayer?.startPoint = CGPoint(x: 0, y: 0.1)
        gradientLayer?.endPoint = CGPoint(x: 1, y: 0.1)
    }
    
    func setGradientColor(colors: [UIColor]){
        var cgColors:[CGColor] = []
        for color in colors{
            cgColors.append(color.cgColor)
        }
        gradientLayer?.colors = cgColors
    }
}
