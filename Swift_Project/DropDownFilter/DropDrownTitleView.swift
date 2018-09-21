//
//  FBDropDrownTitleView.swift
//  Swift_Project
//
//  Created by HongpengYu on 2018/7/2.
//  Copyright © 2018年 HongpengYu. All rights reserved.
//

import UIKit

class DropDrownTitleView: UIView {

    var title: String! {
        didSet {
            if title != oldValue {
                self.titleLabel.text = title
            }
        }
    }
    
    var didClickClosure:((DropDrownTitleView) -> ())?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    convenience init(frame: CGRect, title: String) {
        self.init(frame: frame)
        assert(title.count > 0, "title不能为空")
        self.title = title
        self.titleLabel.text = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.sizeToFit()
        iconImageView.sizeToFit()
        backgroundButton.frame.size = frame.size
    }
    
    // MARK: - Public
    
    func rotateIconView() {
        UIView.animate(withDuration: 0.25) { [weak self] in
            guard let strongSelf = self else {  return  }
            strongSelf.iconImageView.transform = strongSelf.iconImageView.transform.rotated(by: 180 * CGFloat(Double.pi / 180))
        }
    }
    
    
    // MARK: - Private
    private func setupUI() {
        self.addSubview(backgroundButton)
        backgroundButton.addSubview(titleLabel)
        backgroundButton.addSubview(iconImageView)
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(backgroundButton)
            $0.leading.equalTo(backgroundButton).inset(13)
        }
        
        iconImageView.snp.makeConstraints {
            $0.centerY.equalTo(backgroundButton)
            $0.trailing.equalTo(backgroundButton).inset(10)
        }
    }
    
    
    
    
    // MARK: - Action
    @objc
    private func titleViewTapAction() {
        rotateIconView()
        didClickClosure?(self)
    }
    
    
    // MARK: - Lazy
    private lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView(image: UIImage(named: "arrow_down_icon"))
        return iconImageView
    }()
    
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.red
        titleLabel.isUserInteractionEnabled = false
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        return titleLabel
    }()
    
    private lazy var backgroundButton: UIButton = {
        let backgroundButton = UIButton(type: .custom)
        backgroundButton.backgroundColor = UIColor.cyan
        backgroundButton.layer.borderWidth = 0.5
        backgroundButton.layer.cornerRadius = frame.height * 0.5
        backgroundButton.layer.borderColor = UIColor.lightGray.cgColor
        backgroundButton.addTarget(self, action: #selector(DropDrownTitleView.titleViewTapAction), for: .touchUpInside)
        return backgroundButton
    }()
}
