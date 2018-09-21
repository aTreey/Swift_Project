//
//  WebView.swift
//  Swift_Project
//
//  Created by HongpengYu on 2018/7/23.
//  Copyright © 2018年 HongpengYu. All rights reserved.
//

import UIKit

class WebView: UIWebView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        self.addGestureRecognizer(self.longPressGesture)
    }
    
    // MARK: - Action
    
    @objc
    private func longPress(gestrue: UILongPressGestureRecognizer) {
        let touchPoint = gestrue.location(in: self)
        let js = "document.elementFromPoint(\(touchPoint.x), \(touchPoint.y)).src"
        let url = self.stringByEvaluatingJavaScript(from: js)
        
        guard let tempURL = url, !tempURL.isEmpty else { return  }
        print(tempURL)
    }
    
    // MARK: - Lazy
    private lazy var longPressGesture: UILongPressGestureRecognizer = {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPress(gestrue:)))
        longPressGesture.delegate = self
        return longPressGesture
    }()
}

extension WebView: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
