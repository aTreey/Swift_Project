//
//  FBOfflineTrainCalenderCell.swift
//  Swift_Project
//
//  Created by HongpengYu on 2018/5/24.
//  Copyright © 2018年 HongpengYu. All rights reserved.
//

import UIKit

class FBOfflineTrainCalenderCell: UITableViewCell {
    
    static let identifier = "FBOfflineTrainCalenderCell"

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        contentView.addSubview(timeImageView)
        contentView.addSubview(timeLabel)
        contentView.addSubview(containerView)
        containerView.addSubview(courseTitleLabel)
        containerView.addSubview(teacherNameLabel)
        containerView.addSubview(addressLabel)
        containerView.addSubview(courseImageView)
        containerView.addSubview(courseTypeImageView)

        
        timeImageView.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        courseTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        teacherNameLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        courseTypeImageView.translatesAutoresizingMaskIntoConstraints = false
        courseImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: timeImageView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 16).isActive = true
        NSLayoutConstraint(item: timeImageView, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 9).isActive = true
        NSLayoutConstraint(item: timeImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 16).isActive = true
        NSLayoutConstraint(item: timeImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 16).isActive = true
        
        
        NSLayoutConstraint(item: timeLabel, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 15).isActive = true
        NSLayoutConstraint(item: timeLabel, attribute: .leading, relatedBy: .equal, toItem: timeImageView, attribute: .trailing, multiplier: 1, constant: 7).isActive = true
        NSLayoutConstraint(item: timeLabel, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: -16).isActive = true
        
        
        NSLayoutConstraint(item: containerView, attribute: .top, relatedBy: .equal, toItem: timeLabel, attribute: .bottom, multiplier: 1, constant: 5).isActive = true
        NSLayoutConstraint(item: containerView, attribute: .leading, relatedBy: .equal, toItem: timeImageView, attribute: .trailing, multiplier: 1, constant: 7).isActive = true
        NSLayoutConstraint(item: containerView, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: -16).isActive = true
        NSLayoutConstraint(item: containerView, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: -10).isActive = true
        
        
        NSLayoutConstraint(item: courseImageView, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1, constant: 8).isActive = true
        NSLayoutConstraint(item: courseImageView, attribute: .trailing, relatedBy: .equal, toItem: containerView, attribute: .trailing, multiplier: 1, constant: -8).isActive = true
        NSLayoutConstraint(item: courseImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 90).isActive = true
        NSLayoutConstraint(item: courseImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 60).isActive = true
        
        
        NSLayoutConstraint(item: courseTypeImageView, attribute: .top, relatedBy: .equal, toItem: courseImageView, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: courseTypeImageView, attribute: .trailing, relatedBy: .equal, toItem: courseImageView, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: courseTypeImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 32).isActive = true
        NSLayoutConstraint(item: courseTypeImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 32).isActive = true
        
        
        NSLayoutConstraint(item: courseTitleLabel, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1, constant: 8).isActive = true
        NSLayoutConstraint(item: courseTitleLabel, attribute: .leading, relatedBy: .equal, toItem: containerView, attribute: .leading, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: courseTitleLabel, attribute: .trailing, relatedBy: .equal, toItem: courseImageView, attribute: .leading, multiplier: 1, constant: -16).isActive = true
        
        
        NSLayoutConstraint(item: teacherNameLabel, attribute: .top, relatedBy: .equal, toItem: courseTitleLabel, attribute: .bottom, multiplier: 1, constant: 7).isActive = true
        NSLayoutConstraint(item: teacherNameLabel, attribute: .leading, relatedBy: .equal, toItem: containerView, attribute: .leading, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: teacherNameLabel, attribute: .trailing, relatedBy: .equal, toItem: courseImageView, attribute: .leading, multiplier: 1, constant: -16).isActive = true

        
        NSLayoutConstraint(item: addressLabel, attribute: .top, relatedBy: .equal, toItem: teacherNameLabel, attribute: .bottom, multiplier: 1, constant: 4).isActive = true
        NSLayoutConstraint(item: addressLabel, attribute: .leading, relatedBy: .equal, toItem: containerView, attribute: .leading, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: addressLabel, attribute: .trailing, relatedBy: .equal, toItem: courseImageView, attribute: .leading, multiplier: 1, constant: -16).isActive = true
    }
    
    
    private lazy var timeImageView: UIImageView = {
        let timeImageView = UIImageView()
        timeImageView.image = UIImage(named: "lebiIcon2")
        timeImageView.backgroundColor = UIColor.red
        return timeImageView
    }()
    
    private lazy var courseTypeImageView: UIImageView = {
        let courseTypeImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        courseTypeImageView.image = UIImage(named: "lebiIcon2")
        courseTypeImageView.backgroundColor = UIColor.blue
        return courseTypeImageView
    }()
    
    private lazy var courseImageView: UIImageView = {
        let courseImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 90, height: 60))
        courseImageView.image = UIImage(named: "lebiIcon2")
        courseImageView.backgroundColor = UIColor.purple
        return courseImageView
    }()
    
    private lazy var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.font = UIFont.systemFont(ofSize: 14)
        timeLabel.textAlignment = .left
        timeLabel.text = "22:30 即将开始"
        return timeLabel
    }()
    
    private lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        containerView.layer.borderWidth = 0.5
        return containerView
    }()
    
    private lazy var courseTitleLabel: UILabel = {
        let courseTitleLabel = UILabel()
        courseTitleLabel.font = UIFont.systemFont(ofSize: 16)
        courseTitleLabel.textAlignment = .left
        courseTitleLabel.text = "去常营地铁站E口东走100米右转100会议室"
        return courseTitleLabel
    }()
    
    private lazy var addressLabel: UILabel = {
        let addressLabel = UILabel()
        addressLabel.font = UIFont.systemFont(ofSize: 12)
        addressLabel.text = "去常营地铁站E口东走100米右转100会议室"
        addressLabel.textAlignment = .left
        addressLabel.numberOfLines = 0
        return addressLabel
    }()
    
    private lazy var teacherNameLabel: UILabel = {
        let teacherNameLabel = UILabel()
        teacherNameLabel.font = UIFont.systemFont(ofSize: 12)
        teacherNameLabel.text = "徐中"
        teacherNameLabel.textAlignment = .left
        return teacherNameLabel
    }()
    
}
