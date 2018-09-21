//
//  FBCourseCalendarNullDataView.swift
//  Swift_Project
//
//  Created by HongpengYu on 2018/5/31.
//  Copyright © 2018年 HongpengYu. All rights reserved.
//

import UIKit
import SnapKit

class FBCourseCalendarNullDataView: UIView {
    
    var creatButtonActionCompletion: (() -> ())?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        addSubview(nullDataImageView)
        addSubview(tipsLabel)
        addSubview(creatButton)
        
        nullDataImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(50)
            make.centerX.equalTo(self)
            make.width.height.equalTo(200)
        }
        
        tipsLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nullDataImageView.snp.bottom).offset(12)
            make.centerX.equalTo(self)
        }
        
        creatButton.snp.makeConstraints { (make) in
            make.top.equalTo(tipsLabel.snp.bottom).offset(15)
            make.centerX.equalTo(self)
            make.leading.equalTo(self).offset(110)
            make.trailing.equalTo(self).offset(-110)
        }
    }
    
    // MARK: - Action
    @objc
    private func creatButtonAction() {
        creatButtonActionCompletion?()
    }
    
    private lazy var nullDataImageView: UIImageView = {
        let nullDataImageView = UIImageView()
        nullDataImageView.image = UIImage(named: "lebiIcon2")
        nullDataImageView.backgroundColor = UIColor.purple
        return nullDataImageView
    }()
    
    private lazy var tipsLabel: UILabel = {
        let tipsLabel = UILabel()
        tipsLabel.font = UIFont.systemFont(ofSize: 14)
        tipsLabel.textAlignment = .left
        tipsLabel.text = "这天还没有线下课程"
        return tipsLabel
    }()
    
    private lazy var creatButton: UIButton = {
        let creatButton = UIButton(type: .custom)
        creatButton.setTitle("发布培训", for: .normal)
        creatButton.backgroundColor = .orange
        creatButton.layer.cornerRadius = 4.0
        creatButton.layer.masksToBounds = true
        creatButton.addTarget(self, action: #selector(creatButtonAction), for: .touchUpInside)
        return creatButton
    }()

}
