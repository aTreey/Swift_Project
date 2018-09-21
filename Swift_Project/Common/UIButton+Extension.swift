//
//  UIButton+Extension.swift
//  Swift_Project
//
//  Created by HongpengYu on 2018/8/7.
//  Copyright © 2018 HongpengYu. All rights reserved.
//

import UIKit

extension UIButton {
    // 图片相对按钮的位置
    enum ButtonImagePositionStyle {
        /// 图片在上文字在下
        case top
        /// 图片在左文字在右
        case left
        /// 图片在下文字在上
        case bottom
        /// 图片在右文字在左
        case right
    }
    
    /// 设置按钮中图片相对文字的位置，需要再设置玩约束后再设置
    func setTitleAndImagePosition(style: ButtonImagePositionStyle, space: CGFloat = 5.0) {
        let imageWidth = self.imageView?.frame.size.width
        let imageHeight = self.imageView?.frame.size.height
        var titleLabelWidth: CGFloat! = 0.0
        var titleLabelHeight: CGFloat! = 0.0
        
        titleLabelWidth = self.titleLabel?.frame.size.width
        titleLabelHeight = self.titleLabel?.frame.size.height
        
        var imageEdgeInsets = UIEdgeInsets.zero
        var titleEdgeInsets = UIEdgeInsets.zero
        switch style {
        case .top:
            imageEdgeInsets = UIEdgeInsetsMake(-(titleLabelHeight! + space / 2.0), 0, 0, -titleLabelWidth)
            titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth!, -(imageHeight! + space / 2), 0)
        
        case .left:
            imageEdgeInsets = UIEdgeInsetsMake(0, -space / 2.0, 0, space)
            titleEdgeInsets = UIEdgeInsetsMake(0, space / 2.0, 0, -space / 2.0)
            
        case .bottom:
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -(titleLabelHeight! + space / 2.0), -titleLabelWidth!)// 图片下移 -> 右移
            titleEdgeInsets = UIEdgeInsetsMake(-(imageHeight! + space / 2.0), -imageWidth!, 0, 0)// 文字上移 -> 左移
            
        case .right:
            imageEdgeInsets = UIEdgeInsetsMake(0, titleLabelWidth + space / 2.0, 0, -(titleLabelWidth + space / 2.0))
            titleEdgeInsets = UIEdgeInsetsMake(0, -(imageWidth! + space / 2.0), 0, imageWidth! + space / 2.0)
        }
        
        self.titleEdgeInsets = titleEdgeInsets
        self.imageEdgeInsets = imageEdgeInsets
    }
}
