//
//  FBDropdownFilterMenu.swift
//  Swift_Project
//
//  Created by HongpengYu on 2018/6/28.
//  Copyright © 2018年 HongpengYu. All rights reserved.
//

import UIKit

struct DropDownItem: Equatable {
    var title: String = ""
    var itemId: Int = 0
    
    init(title: String, itemId: Int) {
        self.title = title
        self.itemId = itemId
    }
}

class DropDownFilterMenu: UIView {
    
    var didSelectItemClosure: ((DropDownItem) -> ())?
    var items = [DropDownItem]()
    var config = DropDownFilterConfig()
    
    var isAnimating: Bool = false
    var isOpen: Bool = false
    
    var menuSuperView: UIView?
    var react: CGRect?
    var headerView: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(items: [DropDownItem], config: DropDownFilterConfig = DropDownFilterConfig()) {
        self.init()
        self.items = items
        self.config = config
        self.addSubview(backgroundButton)
        self.addSubview(tableView)
        self.addSubview(headerContentView)
        self.clipsToBounds = true
        tableView.didSelectCellClosure = {
            self.hiddenView()
            self.didSelectItemClosure?($0)
        }
        
        headerContentView.backgroundColor = UIColor.red
        headerContentView.snp.makeConstraints { (make) in
            make.bottom.equalTo(tableView.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(200)
        }
    }
    
    
    
    convenience init(items: [DropDownItem], view: UIView, react: CGRect, config: DropDownFilterConfig = DropDownFilterConfig()) {
        self.init(items: items)
        self.menuSuperView = view
        self.react = react
        self.config = config
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Public
    
    func show(in view: UIView, react: CGRect) {
        
        guard isAnimating == false else { return }
        
        if isOpen {
            self.hiddenView()
            return
        }
        
        view.addSubview(self)
        
        let height = CGFloat(items.count) * config.cellHeight
        backgroundButton.frame = CGRect(x: 0, y: 0, width: react.width, height: react.height)
        
        switch config.direction {
        case .top?:
            self.frame = react
            tableView.frame = CGRect(x: 0, y: -height, width: react.width, height: height)
        case .bottom?:
            let frame = react.offsetBy(dx: react.origin.x, dy: -react.height)
            self.frame = frame
            tableView.frame = CGRect(x: 0, y: react.height, width: react.width, height: height)
        default:
            break
        }
        
        
        self.isAnimating = true
        self.backgroundButton.alpha = 0
        UIView.animate(withDuration: config.animationDuration, delay: 0, options: .curveEaseInOut, animations: {
            
            if self.config.direction == .top {
                let frame = self.tableView.frame.offsetBy(dx: 0, dy: height)
                self.tableView.frame = frame
            } else {
                let frame = self.tableView.frame.offsetBy(dx: 0, dy: -height)
                self.tableView.frame = frame
            }
            
            self.backgroundButton.alpha = 1.0
            self.backgroundButton.backgroundColor = self.config.backgroundButtonColor.withAlphaComponent(self.config.backgroundButtonColorAlpha)
        }) { (finished) in
            self.isAnimating = false
            self.isOpen = true
        }
    }
    
    func hiddenView() {
        guard isAnimating == false else { return }
        
        let height = CGFloat(items.count) * config.cellHeight
        self.isAnimating = true
        
        UIView.animate(withDuration: config.animationDuration, delay: 0, options: .curveEaseInOut, animations: {
            var frame: CGRect = .zero
            switch self.config.direction {
            case .top?:
                frame = self.tableView.frame.offsetBy(dx: 0, dy: -height)
            case .bottom?:
                frame = self.tableView.frame.offsetBy(dx: 0, dy: height)
            default:
                break
            }
            self.tableView.frame = frame
            self.backgroundButton.alpha = 0
            self.backgroundButton.backgroundColor = .clear
        }) { (finished) in
            self.isAnimating = false
            self.isOpen = false
            self.removeFromSuperview()
        }
    }
    
    // MARK: - Private
    private func setDirection(direction: DropDownDirection, isShow: Bool, showReact: CGRect) -> CGRect {
        var frame: CGRect = .zero
        let height = CGFloat(items.count) * config.cellHeight

        switch direction {
        case .top:
            //
            if isShow {
                frame = CGRect(x: 0, y: -height, width: showReact.width, height: height)
            } else {
                
            }
        case .bottom:
            //
            if isShow {
                tableView.frame = CGRect(x: 0, y: showReact.height, width: showReact.width, height: height)
            } else {
                
            }
        }
        
        return frame
    }
    
    
    // MARK: - Action
    @objc
    private func backgroundButtonAction() {
        self.hiddenView()
    }
    
    
    // MARK: - Lazy
    
    private lazy var tableView = DropDownFilterTableView(frame: .zero, items: items, selecItem: items[0], config: self.config)
    
    private lazy var headerContentView: UIView = {
        let headerContentView = UIView()
        return headerContentView
    }()
    
    private lazy var backgroundButton: UIButton = {
        let backgroundButton = UIButton()
        backgroundButton.backgroundColor = UIColor.clear
        backgroundButton.addTarget(self, action: #selector(backgroundButtonAction), for: .touchUpInside)
        return backgroundButton
    }()
    
}
