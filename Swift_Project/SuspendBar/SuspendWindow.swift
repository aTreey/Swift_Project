//
//  SuspendWindow.swift
//  Swift_Project
//
//  Created by HongpengYu on 2018/6/11.
//  Copyright © 2018年 HongpengYu. All rights reserved.
//

import UIKit

enum SuspendWindowState {
    case hidden
    case show
}



class SuspendWindow: UIWindow {
    
    static let shared = SuspendWindow()
    weak var navigationController: UINavigationController?
    let screenSize = UIScreen.main.bounds.size
    
    var state: SuspendWindowState = .hidden
    let width: CGFloat = 150
    let shelevViewWidth: CGFloat = UIScreen.main.scale * 20
    var originFrame: CGRect {
        return CGRect(x: screenSize.width, y: screenSize.height, width: width, height: width)
    }
    
    var targetFrame: CGRect {
        return CGRect(x: screenSize.width - width, y: screenSize.height - width, width: width, height: width)
    }
    
    // window上事件响应，如果不是在圆球和右下角的view上就不响应
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let shelveViewPoint = self.convert(point, to: shelveView)
        if shelveView.point(inside: shelveViewPoint, with: event) == true {
            return true
        }
        
        let collectViewPoint = self.convert(point, to: collectView)
        if collectView.point(inside: collectViewPoint, with: event) == true {
            return true
        }
        // 事件传递到下一个响应者
        return false
    }

    init() {
        super.init(frame: UIScreen.main.bounds)
        self.windowLevel = UIWindowLevelStatusBar - 1
        self.backgroundColor = .clear
        self.addSubview(collectView)
        self.addSubview(shelveView)
        
        shelveView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.trailing.equalTo(self).inset(20)
            make.size.equalTo(CGSize(width: shelevViewWidth, height: shelevViewWidth))
        }
        
        shelveView.isHidden = true
        shelveView.alpha = 0
        shelveView.clickClosure = { [weak self] in
            guard let strongSelf = self else {
                return
            }
            strongSelf.pushViewController()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func handleNavigationTransition(gesture: UIScreenEdgePanGestureRecognizer) {
        let point = gesture.location(in: gesture.view)
        switch state {
        case .hidden:
            switch gesture.state {
            case .began:
                self.isHidden = false
                collectView.alpha = 1.0

            case .changed:
                var movePercent = point.x / screenSize.width
                movePercent = max(0, movePercent)
                var frame = collectView.frame
                frame.origin.x = self.frameDelta(origin: originFrame.origin.x, target: targetFrame.origin.x, percent: 1 - movePercent)
                frame.origin.y = self.frameDelta(origin: originFrame.origin.y, target: targetFrame.origin.y, percent: 1 - movePercent)
                collectView.frame = frame
                
                // 是否需要变大
                var isChangeLargen = false
                // 转化坐标
                let collectViewPoint = self.convert(point, to: collectView)
                // 判断是否在view中
                if collectView.point(inside: collectViewPoint, with: nil) == true {
                    isChangeLargen = true
                    updateShelveView()
                }
                
                collectView.updateLayer(isLargen: isChangeLargen)
            case .ended:
                updateSuspenWindow(point)
            case .cancelled:
                updateSuspenWindow(point)
            default:
                break
            }
        default:
            break
        }
    }
    
    // MARK: - Private

    private func pushViewController() {
        let testController = SuspendTestController()
        self.navigationController?.pushViewController(testController, animated: true)
    }
    
    private func updateShelveView() {
        if shelveView.isHidden {
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
                self.shelveView.isHidden = false
                self.shelveView.alpha = 1.0
            }, completion: nil)
        }
    }
    
    private func updateSuspenWindow(_ point: CGPoint) {
        if collectView.frame.contains(point) {
            updateShelveView()
            hiddenCollectView(completion: nil)
        } else {
            hiddenCollectView {
                self.isHidden = true
            }
        }
    }
    
    
    private func hiddenCollectView(completion: (()-> ())?) {
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseOut, animations: {
            self.collectView.alpha = 0
            self.collectView.frame = self.originFrame
        }) { (finished) in
            completion?()
        }
    }
    
    private func frameDelta(origin: CGFloat, target: CGFloat, percent: CGFloat) -> CGFloat {
        return target + (origin - target) * percent
    }
    
    // MARK: - lazy
    
    private lazy var shelveView: SuspendShelveView = {
        let shelveView = SuspendShelveView()
        shelveView.layer.cornerRadius = shelevViewWidth * 0.5
        shelveView.layer.masksToBounds = true
        shelveView.layer.borderWidth = 5
//        shelveView.layer.borderColor = UIColor.orange.cgColor
        return shelveView
    }()
    
    private lazy var collectView: SuspendCollectView = {
        let collectViewFrame = CGRect(x: screenSize.width, y: UIScreen.main.bounds.size.height, width: screenSize.width * 0.5, height: screenSize.width * 0.5)
        let collectView = SuspendCollectView(frame: collectViewFrame)
        return collectView
    }()

}
