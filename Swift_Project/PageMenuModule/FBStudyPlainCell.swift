//
//  FBStudyPlainCell.swift
//  Swift_Project
//
//  Created by HongpengYu on 2018/7/3.
//  Copyright © 2018年 HongpengYu. All rights reserved.
//

import UIKit

class FBStudyPlainCell: UITableViewCell {

    static let identifier = "FBStudyPlainCell"
    
    private let cellEdges = UIEdgeInsetsMake(6, 16, 6, 16)
    private let imageEdges = UIEdgeInsetsMake(18, 9, 18, 9)
    private let imageSize = CGSize(width: 90, height: 60)
    private let arrowImageSize = CGSize(width: 8, height: 14)
    
    private let labelMargin = 9
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        contentView.backgroundColor = UIColor(hexString: "#F0F0F0")
        contentView.backgroundColor = UIColor.gray
        self.selectionStyle = .none
        setupUI()
        updateUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func updateUI() {
        titleLabel.text = "视频课程"
        courseTypeLabel.text = "课程类型"
        lecturerNameLabel.text = "讲师：徐中"
        stateLabel.text = "已完成"
    }
    
    private func setupUI() {
        contentView.addSubview(containerView)
        containerView.addSubview(courseImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(lecturerIcon)
        containerView.addSubview(lecturerNameLabel)
        containerView.addSubview(arrowImageView)
        containerView.addSubview(stateLabel)
        
        courseImageView.addSubview(titleBackgroundView)
        titleBackgroundView.addSubview(courseTypeLabel)
        
        containerView.snp.makeConstraints {
            $0.edges.equalTo(cellEdges)
        }
        
        courseImageView.snp.makeConstraints {
            $0.size.equalTo(imageSize)
            $0.top.leading.bottom.equalTo(imageEdges)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(27)
            $0.leading.equalTo(courseImageView.snp.trailing).offset(labelMargin)
        }
        
        lecturerIcon.snp.makeConstraints {
            $0.leading.equalTo(titleLabel)
            $0.top.equalTo(titleLabel.snp.bottom).inset(-10)
        }
        
        lecturerNameLabel.snp.makeConstraints {
            $0.centerY.equalTo(lecturerIcon)
            $0.leading.equalTo(lecturerIcon.snp.trailing).offset(3)
        }
        
        arrowImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(5)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(arrowImageSize)
        }
        
        stateLabel.snp.makeConstraints {
            $0.trailing.equalTo(arrowImageView.snp.leading).offset(-10)
            $0.centerY.equalToSuperview()
        }
        
        titleBackgroundView.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.leading.trailing.bottom.width.equalToSuperview()
        }
        
        courseTypeLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(6)
        }
    }
    
    
    private lazy var titleBackgroundView: UIView = {
        let titleBackgroundView = UIView()
//        titleBackgroundView.backgroundColor = UIColor(hexString: "#000000").withAlphaComponent(0.5)
        titleBackgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return titleBackgroundView
    }()
    
    
    private lazy var courseImageView: UIImageView = {
        let courseImageView = UIImageView()
        courseImageView.image = UIImage(named: "icon_cat")
        return courseImageView
    }()
    
    private lazy var lecturerIcon: UIImageView = {
        let lecturerIcon = UIImageView()
        lecturerIcon.image = UIImage(named: "icon_cat")
        return lecturerIcon
    }()
    
    private lazy var arrowImageView: UIImageView = {
        let arrowImageView = UIImageView()
        arrowImageView.image = UIImage(named: "arrow_down_icon")
        return arrowImageView
    }()
    
    private lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        containerView.layer.borderWidth = 0.5
        containerView.backgroundColor = .white
        return containerView
    }()
    
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textAlignment = .left
        return titleLabel
    }()
    
    
    private lazy var lecturerNameLabel: UILabel = {
        let lecturerNameLabel = UILabel()
        lecturerNameLabel.font = UIFont.systemFont(ofSize: 12)
        lecturerNameLabel.textAlignment = .left
//        lecturerNameLabel.textColor = UIColor(hexString: "#333333")
        return lecturerNameLabel
    }()
    
    private lazy var courseTypeLabel: UILabel = {
        let courseTypeLabel = UILabel()
        courseTypeLabel.font = UIFont.systemFont(ofSize: 12)
//        courseTypeLabel.textColor = UIColor(hexString: "#FFFFFF")
        courseTypeLabel.textAlignment = .left
        courseTypeLabel.preferredMaxLayoutWidth = 90
        return courseTypeLabel
    }()
    
    private lazy var stateLabel: UILabel = {
        let stateLabel = UILabel()
        stateLabel.font = UIFont.systemFont(ofSize: 14)
        stateLabel.textAlignment = .center
//        stateLabel.textColor = UIColor(hexString: "#333333")
        stateLabel.preferredMaxLayoutWidth = 45
        stateLabel.numberOfLines = 2
        stateLabel.text = "进行中"
        return stateLabel
    }()
}
