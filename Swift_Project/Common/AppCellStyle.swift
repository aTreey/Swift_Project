//
//  AppCellStyle.swift
//  Swift_Project
//
//  Created by HongpengYu on 2018/8/8.
//  Copyright © 2018 HongpengYu. All rights reserved.
//

import UIKit

struct CourseCell {
    /// 课程封面图片边距
    static let courseImageEdges = UIEdgeInsetsMake(18, 8, 18, 8)
    /// 课程封面图片尺寸
    static let courseImageSize = CGSize(width: 90, height: 60)
    /// 课程封面图片尺寸2, 如果是重写了cell的frame属性实现cell间距，需要加上间距大小
    static let courseImageSize2 = CGSize(width: 90, height: 60 + 12) //
    /// 右边箭头尺寸
    static let arrowImageSize = CGSize(width: 8, height: 14)
    /// 时间图标尺寸
    static let timeIconSize: CGSize = CGSize(width: 12, height: 12)
    /// 考试状态背景大小
    static let examStateSize = CGSize(width: 55, height: 18)
    /// label 间距
    static let labelMargin = 9
    /// 阴影宽度(根据不同屏幕尺寸缩放)
    static let shadowWidth = UIScreen.main.scale * 0.5
    /// 分割线高度(根据不同屏幕尺寸缩放)
    static let separateHight = UIScreen.main.scale * 1.0
    
}
