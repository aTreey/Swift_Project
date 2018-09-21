//
//  FBDropDownFilterConfig.swift
//  Swift_Project
//
//  Created by HongpengYu on 2018/7/2.
//  Copyright © 2018年 HongpengYu. All rights reserved.
//

import UIKit

struct DropDownFilterConfig {
    /// cell的高度
    var cellHeight: CGFloat!
    /// cell的背景颜色
    var cellBackgroundColor: UIColor!
    /// cell 文字颜色
    var cellTextColor: UIColor!
    /// cell 选中的背景颜色
    var cellSelectBackgroundColor: UIColor!
    /// cell 选中的文字颜色
    var cellSelectTextColor: UIColor!
    /// cell 文字大小
    var cellTextFont: CGFloat!
    var cellTextAlignment: NSTextAlignment!
    
    var isShowCellSeparator = true
    var cellSeparatorInset: UIEdgeInsets!
    
    var backgroundButtonColor: UIColor!
    var backgroundButtonColorAlpha: CGFloat!
    var animationDuration: TimeInterval!
    
    var direction: DropDownDirection!
    
    init() {
        setupDefault()
    }
    
    private mutating func setupDefault() {
        
        self.cellHeight = 44.0
        self.cellBackgroundColor = UIColor.lightGray
        self.cellTextColor = UIColor.darkText
        self.cellTextFont = 14.0
        self.cellSelectTextColor = UIColor.orange
        self.cellSelectBackgroundColor = UIColor.white
        self.cellTextAlignment = .left
        
        self.isShowCellSeparator = true
        self.cellSeparatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        self.backgroundButtonColor = UIColor.black
        self.backgroundButtonColorAlpha = 0.5
        self.animationDuration = 0.25
        self.direction = .top
    }
}

enum DropDownDirection: Int {
    case top
    case bottom
//    case left
//    case right
}
