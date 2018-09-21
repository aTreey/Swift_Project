//
//  SuspendCollectView.swift
//  Swift_Project
//
//  Created by HongpengYu on 2018/6/11.
//  Copyright © 2018年 HongpengYu. All rights reserved.
//

import UIKit

// 浮层暂存View
class SuspendShelveView: UIView {
    
    var clickClosure: (() -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addGestureRecognizer(tap)
        self.layer.cornerRadius = frame.size.width * 0.5
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor.orange
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func tagGesture(gesture: UITapGestureRecognizer) {
        clickClosure?()
    }
    
    
    // MARK: - Lazy
    lazy var tap: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tagGesture(gesture:)))
        return tap
    }()
}


/// 右下角view
class SuspendCollectView: UIView {
    
    lazy var viewSize = self.bounds.size
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        updateLayer(isLargen: false)
    }
    
    // 判断触摸点是否在视图内
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return backgroundLayer.path!.contains(point)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func updateLayer(isLargen: Bool) {
        var scale: CGFloat = 1.0
        if isLargen {
            scale = 1.5
        }
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: viewSize.width, y: (1 - scale) * viewSize.height))
        path.addLine(to: CGPoint(x: viewSize.width, y: viewSize.height))
        path.addLine(to: CGPoint(x: (1 - scale) * viewSize.width, y: viewSize.height))
        path.addArc(withCenter: CGPoint(x: viewSize.width, y: viewSize.height), radius: viewSize.width * scale, startAngle: CGFloat(Double.pi), endAngle: CGFloat(Double.pi * 3 / 2), clockwise: true)
        path.close()
        backgroundLayer.path = path.cgPath
        
    }
    
    // MARK: - lazy
    
    lazy var backgroundLayer: CAShapeLayer = {
        let backgroundLayer = CAShapeLayer()
        backgroundLayer.fillColor = UIColor.green.cgColor
        self.layer.addSublayer(backgroundLayer)
        backgroundLayer.frame = self.bounds
        return backgroundLayer
    }()
}
