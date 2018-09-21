//
//  FBPageViewConfig.swift
//  Swift_Project
//
//  Created by HongpengYu on 2018/7/4.
//  Copyright © 2018年 HongpengYu. All rights reserved.
//

import UIKit

struct FBPageViewConfig {
    
    /// titleView 高度
    var titleViewHeight: CGFloat = 40
    var itemMargin: CGFloat = 45
    
    /// 背景颜色
    var backgoundColor = UIColor.white
    
    var isChangeSelectTextColor = false
    
    /// 文字颜色
    var normalTextColor: UIColor!
    /// 选中时文字颜色
    var selectTextColor: UIColor!
    /// 底部选中线颜色
    var selectIdentifierColor: UIColor!
    /// 底部选中线高度
    var selectIdentifierHeight: CGFloat = 2.0
    /// 是否显示底部细线
    var isShowBottomLine = true
    var bottomLineColor: UIColor!
    
    /// 是否显示选中标识
    var isShowSelectIdentifier = false
    /// 选中标识延伸长度,默认是10
    var selectIdentifierExtend: CGFloat = 10.0
    /// 选中文字是否缩放
    var isScaleFontWhenSelected = false
    /// 正常文字大小
    var normalTextFont: CGFloat = 14.0
    /// 选中时文字大小
    var selectTextFont: CGFloat = 16.0
    
    
    init() {
        setupDefault()
    }
    
    private mutating func setupDefault() {
        normalTextColor = UIColor.black
        selectTextColor = UIColor.orange
        selectIdentifierColor = UIColor.yellow
        isShowSelectIdentifier = true
        isScaleFontWhenSelected = false
        normalTextFont = 14
        selectTextFont = 16
        bottomLineColor = UIColor.red
    }
}
