//
//  APPColor.swift
//  Swift_Project
//
//  Created by HongpengYu on 2018/7/14.
//  Copyright © 2018年 HongpengYu. All rights reserved.
//

import UIKit
import Hue

extension UIColor {
    /// app 主题颜色 "#EF8200"
    class func appTheme() -> UIColor {
        return UIColor(hex: "#EF8200")
    }
    
    /// app 浅色主题色 #EA8F54
    class func appLightTheme() -> UIColor {
        return UIColor(hex: "#EA8F54")
    }
    
    /// app 主题中灰色背景颜色 "#F0F0F0"
    class func appThemeBackground() -> UIColor {
        return UIColor(hex: "#F0F0F0")
    }
    
    /// app view 或子控件的背景颜色 "#F7F7F7"
    class func appViewBackground() -> UIColor {
        return UIColor(hex: "#F7F7F7")
    }
    
    /// app 白色颜色 "#FFFFFF"
    class func appWhite() -> UIColor {
        return UIColor(hex: "#FFFFFF")
    }
    
    /// app view阴影颜色 / 分割线颜色 "#DCDCDC"
    class func appShadow() -> UIColor {
        return UIColor(hex: "#DCDCDC")
    }
    
    /// app 文字正常颜色 "#333333"
    class func appNormalText() -> UIColor {
        return UIColor(hex: "#333333")
    }
    
    /// app 文字黑色颜色 "#000000"
    class func appBlackText() -> UIColor {
        return UIColor(hex: "#000000")
    }
    
    /// app 文字灰色颜色 "#999999"
    class func appGrayText() -> UIColor {
        return UIColor(hex: "#999999")
    }
    
    /// app 文字深灰色颜色 "#999999"
    class func appDarkGrayText() -> UIColor {
        return UIColor(hex: "#666666")
    }
    
    /// app 分割线颜色 "#DCDCDC"
    class func appSeparater() -> UIColor {
        return UIColor(hex: "#DCDCDC")
    }
}
