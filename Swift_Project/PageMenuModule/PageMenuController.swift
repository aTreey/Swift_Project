//
//  PageMenuController.swift
//  Swift_Project
//
//  Created by HongpengYu on 2018/6/25.
//  Copyright © 2018年 HongpengYu. All rights reserved.
//

import UIKit

class PageMenuController: UIViewController {
    
    let menuItemHeight: CGFloat = 50
    let menuItemWidth: CGFloat = 100
    
    var controllers: [UIViewController] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraint()
        addSubControllers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    init(controllers: [UIViewController], frame: CGRect) {
        super.init(nibName: nil, bundle: nil)
        self.controllers = controllers
        self.view.frame = frame
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func addSubControllers() {
        menuScrollView.contentSize = CGSize(width: menuItemWidth * CGFloat(controllers.count), height: menuItemHeight)
        for controller in controllers {
            
        }
    }
    
    private func setupConstraint() {
        view.addSubview(menuScrollView)
        menuScrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: menuScrollView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: menuScrollView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1.0, constant: menuItemHeight).isActive = true
        
        view.addSubview(controllersScrollView)
        controllersScrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: controllersScrollView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: controllersScrollView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1.0, constant: 0).isActive = true
    }
    
    
    // MARK: - Lazy
    private lazy var  menuScrollView: UIScrollView = {
        let menuScrollView = UIScrollView()
        menuScrollView.isPagingEnabled = true
        menuScrollView.alwaysBounceHorizontal = true
        menuScrollView.bounces = true
        menuScrollView.showsVerticalScrollIndicator = true
        menuScrollView.showsHorizontalScrollIndicator = true
        menuScrollView.backgroundColor = .blue
        return menuScrollView
    }()
    
    private lazy var  controllersScrollView: UIScrollView = {
        let controllersScrollView = UIScrollView()
        controllersScrollView.isPagingEnabled = true
        controllersScrollView.alwaysBounceHorizontal = true
        controllersScrollView.bounces = true
        controllersScrollView.showsVerticalScrollIndicator = true
        controllersScrollView.showsHorizontalScrollIndicator = true
        menuScrollView.backgroundColor = .green
        return controllersScrollView
    }()
    
    

}
