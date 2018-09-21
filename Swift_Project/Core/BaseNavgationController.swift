//
//  BaseNavgationCotroller.swift
//  Swift_Project
//
//  Created by HongpengYu on 2018/6/11.
//  Copyright © 2018年 HongpengYu. All rights reserved.
//

import UIKit

class BaseNavgationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self

        // 是否将响应事件发送给视图，
        self.interactivePopGestureRecognizer?.delaysTouchesBegan = true
        self.interactivePopGestureRecognizer?.isEnabled = true
        self.interactivePopGestureRecognizer?.delegate = self

        // 给view添加边缘Pan手势，获取pop 手势的进度
        let edgePanGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleNavigationTransition(gesture:)))
        // 指定边缘
        /**
         UIPanGestureRecognizer的这个子类只有在用户滑动手指时才能识别
         从指定边缘的边框。
         */
        edgePanGesture.edges = .left
        self.view.addGestureRecognizer(edgePanGesture)
    }

    @objc
    private func handleNavigationTransition(gesture: UIScreenEdgePanGestureRecognizer) {
        SuspendWindow.shared.navigationController = self
        SuspendWindow.shared.handleNavigationTransition(gesture: gesture)
    }
}

extension BaseNavgationController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.viewControllers.count > 1
    }
    
    /// 支持同时识别多个手势
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension BaseNavgationController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
//        print("willShow --- viewController = \(viewController)")
    }

    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
//        print("didShow --- viewController = \(viewController)" )
    }

    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        print(animationController)
        return nil
    }

    // TODO: 自定义转场动画
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        print("operation = \(operation) --- fromVC = \(fromVC) toVC = \(toVC) ")
        return nil
    }
    
}
