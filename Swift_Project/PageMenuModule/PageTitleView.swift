//
//  FBPageTitleView.swift
//  Swift_Project
//
//  Created by HongpengYu on 2018/6/25.
//  Copyright © 2018年 HongpengYu. All rights reserved.
//

import UIKit

protocol FBPageTitleViewDelegate: class {
    func pageTitleView(_ pageTitleView: PageTitleView, didSelect index: Int)
}

class PageTitleView: UIView {
    weak var delegate: FBPageTitleViewDelegate?
    
    var config = FBPageViewConfig()

    var titleArray: [String] = [] {
        didSet {
            setupTitleViews()
            self.setNeedsLayout()
        }
    }
    
    private var selectIndex: Int = 0
    private var buttonArray = [UIButton]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    convenience init(frame: CGRect, config: FBPageViewConfig = FBPageViewConfig()) {
        self.init(frame: frame)
        self.config = config
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        scrollView.frame = bounds
        if titleArray.count == 0 {
            return
        }
        setupTitleFrame()
    }

    
    func updateState(selectIndex: Int) {
        let selectButton = buttonArray[selectIndex]
        changeState(sender: selectButton)
        scroll2Center(sender: selectButton)
    }
    
    private func setupTitleViews() {
        buttonArray.forEach { (view) in
            view.removeFromSuperview()
        }
        buttonArray.removeAll()
        
        for title in titleArray {
            let button = UIButton(type: .custom)
            button.setTitle(title, for: .normal)
            button.setTitleColor(config.normalTextColor, for: .normal)
            button.setTitleColor(config.selectTextColor, for: .selected)
            button.titleLabel?.font = UIFont.systemFont(ofSize: config.normalTextFont)
            button.addTarget(self, action: #selector(PageTitleView.buttonAction(sender:)), for: .touchUpInside)
            scrollView.addSubview(button)
            buttonArray.append(button)
        }
    }
    
    private func setupTitleFrame() {
        var allButtonsWidth: CGFloat = 0
        titleArray.forEach({ (title) in
            allButtonsWidth += calculateButtonWidth(title: title, font: UIFont.systemFont(ofSize: config.normalTextFont))
        })
        
        let buttonMargin: CGFloat = config.itemMargin
        allButtonsWidth += buttonMargin * CGFloat(titleArray.count)
        
        var button_x: CGFloat = 0
        let button_y: CGFloat = 0
        var button_width: CGFloat = 0
        let button_height = config.titleViewHeight
        
        if allButtonsWidth < UIScreen.main.bounds.width, allButtonsWidth > 0 {
            button_width = (UIScreen.main.bounds.width - buttonMargin * CGFloat(titleArray.count)) / CGFloat(titleArray.count)
            button_width = CGFloat(ceil(button_width))
        }
        
        for (index, title) in titleArray.enumerated() {
            let button = buttonArray[index]
            if button_width == 0 {
                let buttonWidth = calculateButtonWidth(title: title, font: UIFont.systemFont(ofSize: config.normalTextFont)) + buttonMargin
                button.frame = CGRect(x: button_x, y: button_y, width: buttonWidth, height: button_height)
                
            } else {
                button.frame = CGRect(x: button_x, y: button_y, width: button_width + buttonMargin, height: button_height)
            }
            button_x += button.frame.width
        }
        
        let scrollView_width = buttonArray.last?.frame.maxX
        scrollView.contentSize = CGSize(width: scrollView_width ?? 0, height: 0)
        
        if config.isShowBottomLine {
            let bottomLine_height = 1.0 / UIScreen.main.scale
            bottomLine.frame = CGRect(x: 0, y: bounds.height - bottomLine_height, width: bounds.width, height: bottomLine_height)
        }
        
        if config.isChangeSelectTextColor {
            buttonArray[selectIndex].isSelected = true
        }
        
        if config.isScaleFontWhenSelected {
            buttonArray[selectIndex].titleLabel?.font = UIFont.systemFont(ofSize: config.selectTextFont)
        }
        
        if config.isShowSelectIdentifier {
            let selectButton = buttonArray[selectIndex]
            let setectIdentifier_x = floor(selectButton.frame.minX + (selectButton.frame.width - (selectButton.titleLabel?.frame.width)!) / 2)
            let setectIdentifier_width = ceil(selectButton.titleLabel?.frame.width ?? 0)
            setectIdentifier.frame = CGRect(x: setectIdentifier_x, y: bounds.height - 2, width: setectIdentifier_width, height: 2)
        }
    }
    
    private func calculateButtonWidth(title: String, font: UIFont) -> CGFloat {
        let attributeDict = [NSAttributedStringKey.font: font]
        let rect = NSString(string: title).boundingRect(with: CGSize.zero, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attributeDict, context: nil)
        return CGFloat(ceil(rect.size.width))
    }
    
    private func changeState(sender: UIButton) {
        let previousSelectButton = buttonArray[selectIndex]

        if config.isScaleFontWhenSelected {
            previousSelectButton.titleLabel?.font = UIFont.systemFont(ofSize: config.normalTextFont)
            sender.titleLabel?.font = UIFont.systemFont(ofSize: config.selectTextFont)
        }
        
        if config.isChangeSelectTextColor {
            previousSelectButton.isSelected = false
            sender.isSelected = true
        }
        
        
        if config.isShowSelectIdentifier {
            let setectIdentifier_x = floor(sender.frame.minX + (sender.frame.width - (sender.titleLabel?.frame.width)!) / 2) - config.selectIdentifierExtend
            let setectIdentifier_width = ceil(sender.titleLabel?.frame.width ?? 0)
            
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
                self.setectIdentifier.frame = CGRect(x: setectIdentifier_x, y: self.bounds.height - 2, width: setectIdentifier_width + self.config.selectIdentifierExtend, height: 2)
                self.setectIdentifier.center.x = sender.center.x
                self.scrollView.layoutIfNeeded()
            }) { (finished) in
                self.selectIndex = self.buttonArray.index(of: sender)!
            }
        }
    }
    
    private func scroll2Center(sender: UIButton) {
        let maxOffset_x = scrollView.contentSize.width - frame.width
        var offset_x = sender.center.x - frame.width * 0.5
        if offset_x < 0 {
            offset_x = 0
        }
        
        if offset_x > maxOffset_x {
            offset_x = maxOffset_x
        }
        scrollView.setContentOffset(CGPoint(x: offset_x, y: 0), animated: true)
    }
    
    // MARK: - Action
    @objc
    private func buttonAction(sender: UIButton) {
        changeState(sender: sender)
        scroll2Center(sender: sender)
        delegate?.pageTitleView(self, didSelect: buttonArray.index(of: sender)!)
    }
    
    
    private func setup() {
        addSubview(scrollView)
        scrollView.addSubview(setectIdentifier)
    }
    
    
    // MARK: - Lazy
    
    private lazy var bottomLine: CALayer = {
        let bottomLine = CALayer()
        bottomLine.backgroundColor = config.bottomLineColor.cgColor
        self.layer.addSublayer(bottomLine)
        return bottomLine
    }()
    
    private lazy var setectIdentifier : UIView = {
        let setectIdentifier = UIView()
        setectIdentifier.backgroundColor = config.selectTextColor
        return setectIdentifier
    }()

    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.backgroundColor = .cyan
        titleLabel.numberOfLines = 0
        return titleLabel
    }()
    
    private lazy var selectBackgroundImageView: UIImageView = {
        let selectBackgroundImageView = UIImageView(image: UIImage(named: "icon_cat"))
        return selectBackgroundImageView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = config.backgoundColor
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.alwaysBounceVertical = false
        scrollView.alwaysBounceHorizontal = false
        scrollView.isMultipleTouchEnabled = true
        return scrollView
    }()
}
