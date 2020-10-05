//
//  Constants.swift
//  TKTLibrary
//
//  Created by Nguyen Hieu Trung on 9/8/20.
//  Copyright © 2020 NHTSOFT. All rights reserved.
//

import UIKit

public enum TKTImage: String{
    case changeCamera = "iconChangeCamera"
    case iconCamera = "iconCamera"
}

enum TKTLanguage: String{
    case VI = "vi"
    case EN = "en"
}

var appLanguage = TKTLanguage.EN

//MARK : Screen Type
struct ScreenSize {
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

struct DeviceType {
    static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPHONE_8           = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 750.0
    static let IS_IPHONE_X          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 812
    static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH   == 1024.0
    static let IS_IPAD_PRO          = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH   == 1366.0
    static let IS_IPHONE_XSMAX      = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 896
    static let IS_IPHONE_XR         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 896
}

//MARK: Height header
var heightIphoneXDevice: CGFloat = 88
var heightIphoneOtherDevice: CGFloat = 65

//MARK: KEY FILTER
enum SKIN_KEY:String{
    case FACE = ""
    case SPOT = "SkinSpot"
    case ACNE = "SkinAcne"
    case PIMPLE = "SkinPimple"
    case BLACK_HEAD = "SkinBlackHeads"
    case MOLE = "SkinMole"
}

enum TKT_TAG: Int {
    case FACE = 1000
    case SPOT = 1010
    case ACNE = 1020
    case PIMPLE = 1030
    case BLACK_HEAD = 1040
    case MOLE = 1050
}

var DEFAULT_IMAGE_SIZE:CGFloat = 640

