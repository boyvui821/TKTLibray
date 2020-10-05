//
//  UIColor+Extension.swift
//  TKTLibrary
//
//  Created by Nguyen Hieu Trung on 9/8/20.
//  Copyright © 2020 NHTSOFT. All rights reserved.
//

import UIKit

extension UIColor{
    public convenience init?(hexString: String, alpha: CGFloat = 1.0) {
        var hexSanitized = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt32 = 0

        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = alpha

        let length = hexSanitized.count

        guard Scanner(string: hexSanitized).scanHexInt32(&rgb) else { return nil }

        if length == 6 {
            red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            blue = CGFloat(rgb & 0x0000FF) / 255.0

        } else if length == 8 {
            red = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            green = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            blue = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            alpha = CGFloat(rgb & 0x000000FF) / 255.0

        } else {
            return nil
        }

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

    public class var applicationColor: UIColor{
        get{
            return UIColor(red: 0.99, green: 0.62, blue: 0.73, alpha: 1.00)
        }
    }
    
    public class var formBorder: UIColor{
        get{
            return UIColor(red: 0.78, green: 0.78, blue: 0.78, alpha: 1.00)
        }
    }
    
    public class var blackHead: UIColor{
        get{
            return UIColor(red: 0.44, green: 0.30, blue: 0.97, alpha: 1.00)
        }
    }
    
    public class var spot: UIColor{
        get{
            return UIColor(red: 0.99, green: 0.80, blue: 0.24, alpha: 1.00)
        }
    }
    
    public class var acne: UIColor{
        get{
            return UIColor(red: 0.16, green: 0.85, blue: 0.40, alpha: 1.00)
        }
    }
    
    public class var pimple: UIColor{
        get{
            return UIColor(red: 0.93, green: 0.26, blue: 0.27, alpha: 1.00)
        }
    }
    
    public class var mole: UIColor{
        get{
            return UIColor(red: 0.24, green: 0.51, blue: 0.98, alpha: 1.00)
        }
    }
    
    
    
    
    
    
}
