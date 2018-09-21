//
//  FBOfflineTrainClenderController.swift
//  Swift_Project
//
//  Created by HongpengYu on 2018/5/24.
//  Copyright © 2018年 HongpengYu. All rights reserved.
//

import UIKit
import FSCalendar

class FBOfflineTrainClenderController: UIViewController {
    
    var containerViewHeightConstraint: NSLayoutConstraint!
    
    var dataSource: Int = 0
    
    lazy var courseCount: [[String: Int]] = [["2018/06/01": 2],
                                             ["2018/06/13": 4],
                                             ["2018/06/18": 6],
                                             ["2018/06/22": 4],
                                             ["2018/06/26": 8],
                                             ["2018/06/28": 4],
                                             ["2018/06/30": 10]];

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupUI()
        let todayItem = UIBarButtonItem(title: "今天", style: .plain, target: self, action: #selector(todayItemClicked(sender:)))
        self.navigationItem.rightBarButtonItem = todayItem
        dataSource = 10
        
        view.addGestureRecognizer(scopeGesture)
        tableView.panGestureRecognizer.require(toFail: self.scopeGesture)
        
        if dataSource == 0 {
            nullDataView.backgroundColor = UIColor.lightGray
            view.addSubview(nullDataView)
            
            nullDataView.snp.makeConstraints { (make) in
                make.top.equalTo(containerView.snp.bottom)
                make.leading.bottom.trailing.equalTo(view)
            }
        } else {
            nullDataView.removeFromSuperview()
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.scrollToRow(at: IndexPath(row: 8, section: 0), at: .top, animated: true)
    }
    
    
    // MARK: - Private
    private func setupUI() {
        view.addSubview(containerView)
        containerView.addSubview(calendar)
        containerView.addSubview(switchControl)
        containerView.addSubview(switchTipsLabel)
        view.addSubview(tableView)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        calendar.translatesAutoresizingMaskIntoConstraints = false
        switchControl.translatesAutoresizingMaskIntoConstraints = false
        switchTipsLabel.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false

        
        NSLayoutConstraint(item: containerView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 64).isActive = true
        NSLayoutConstraint(item: containerView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: containerView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        containerViewHeightConstraint = NSLayoutConstraint(item: containerView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 500)
        containerViewHeightConstraint.isActive = true
       
        
        NSLayoutConstraint(item: calendar, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: calendar, attribute: .leading, relatedBy: .equal, toItem: containerView, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: calendar, attribute: .trailing, relatedBy: .equal, toItem: containerView, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: calendar, attribute: .bottom, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1.0, constant: -40).isActive = true
        
        
        NSLayoutConstraint(item: switchControl, attribute: .top, relatedBy: .equal, toItem: calendar, attribute: .bottom, multiplier: 1.0, constant: 6).isActive = true
        NSLayoutConstraint(item: switchControl, attribute: .trailing, relatedBy: .equal, toItem: containerView, attribute: .trailing, multiplier: 1.0, constant: -16).isActive = true

        
        NSLayoutConstraint(item: switchTipsLabel, attribute: .trailing, relatedBy: .equal, toItem: switchControl, attribute: .leading, multiplier: 1.0, constant: -8).isActive = true
        NSLayoutConstraint(item: switchTipsLabel, attribute: .centerY, relatedBy: .equal, toItem: switchControl, attribute: .centerY, multiplier: 1.0, constant: 0).isActive = true
        
        
        NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: tableView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: tableView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: -49).isActive = true
    }
    
    
    
    // MARK: - Action
    @objc
    private func todayItemClicked(sender: UIBarButtonItem) {
        calendar.setCurrentPage(Date(), animated: true)
    }
    
    @objc
    private func changeSwitchControlValue(sender: UISwitch) {
        calendar.setScope(.week, animated: true)
        print(sender.isOn)
    }
    
    
    // MARK: - lazy
    
    
    private lazy var nullDataView = FBCourseCalendarNullDataView()
    
    private let gregorian = Calendar(identifier: .gregorian)
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
    
    private lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .cyan
        return containerView
    }()
    
    private lazy var switchTipsLabel: UILabel = {
        let switchTipsLabel = UILabel()
        switchTipsLabel.font = UIFont.systemFont(ofSize: 14)
        switchTipsLabel.textAlignment = .right
        switchTipsLabel.text = "只显示必修课"
        return switchTipsLabel
    }()
    
    private lazy var switchControl: UISwitch = {
        let switchControl = UISwitch()
        switchControl.addTarget(self, action: #selector(changeSwitchControlValue(sender:)), for: .valueChanged)
        return switchControl
    }()
    
    private lazy var scopeGesture: UIPanGestureRecognizer = {
        [unowned self] in
        let panGesture = UIPanGestureRecognizer(target: calendar, action: #selector(calendar.handleScopeGesture(_:)))
        panGesture.delegate = self
        panGesture.minimumNumberOfTouches = 1
        panGesture.maximumNumberOfTouches = 2
        return panGesture
    }()
    
    private lazy var calendar: FSCalendar = {
        let calendar = FSCalendar(frame: .zero)
        calendar.dataSource = self
        calendar.delegate = self
        calendar.scope = .month
        // 日历背景颜色
        calendar.backgroundColor = .white
        calendar.weekdayHeight = 24
        calendar.headerHeight = 0
        
        calendar.calendarHeaderView.backgroundColor = UIColor.cyan.withAlphaComponent(0.2) //#FFFFFF
        calendar.calendarWeekdayView.backgroundColor = UIColor.gray.withAlphaComponent(0.2) // #F7F7F7
        
        calendar.appearance.weekdayFont = UIFont.systemFont(ofSize: 14)
        calendar.appearance.titleFont = UIFont.systemFont(ofSize: 14)
        calendar.appearance.subtitleFont = UIFont.systemFont(ofSize: 10)
        calendar.appearance.titleOffset = CGPoint(x: 0, y: -5)
        calendar.appearance.imageOffset = CGPoint(x: 0, y: -5)
        calendar.appearance.separators = .interRows
        calendar.appearance.headerDateFormat = "yyyy年MM月"
        calendar.appearance.caseOptions = .weekdayUsesSingleUpperCase
        calendar.appearance.borderRadius = 0
        calendar.appearance.weekdayTextColor = UIColor.darkText // #333333
        calendar.appearance.todayColor = UIColor.orange // #EF8200
        calendar.appearance.selectionColor = UIColor.gray
        calendar.appearance.todaySelectionColor = UIColor.orange
        
        return calendar
    }()
    
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .white
        tableView.register(FBOfflineTrainCalenderCell.self, forCellReuseIdentifier: FBOfflineTrainCalenderCell.identifier)
        tableView.dataSource = self
        tableView.rowHeight = 130
        return tableView
    }()
}


extension FBOfflineTrainClenderController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FBOfflineTrainCalenderCell.identifier, for: indexPath) as! FBOfflineTrainCalenderCell
        return cell
    }
}


// MARK: - FSCalendarDelegate
extension FBOfflineTrainClenderController: FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        return true
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("选中的日期=\(date)")
    }
    
    // 小圆点
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        return 1
    }
    //  农历
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        return LunarFormatter().string(from: date)
    }
    
    // 线下课数量
    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
        
        let dateStr = self.dateFormatter.string(from: date)
        var image: UIImage?
        courseCount.forEach { (infoDic) in
            if infoDic.keys.contains(dateStr) {
                var textBackColol = UIColor.lightGray
                let dateStamp = date.timeIntervalSince1970
                let nowStamp = Date().timeIntervalSince1970
                if dateStamp - nowStamp > 0 {
                    textBackColol = UIColor.orange
                }
                let text = String(infoDic[dateStr]!)
                image = self.generateImage(text: text, backgroundColor: textBackColol, size: CGSize(width: 20, height: 16))
            }
        }
        return image
    }
    
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.containerViewHeightConstraint.constant = bounds.height + 40
        self.view.layoutIfNeeded()
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {
        if monthPosition == .current {
            
        }
//        print("willDisplay cell----data = \(date), monthPosition = \(monthPosition.rawValue)")
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
//        print("--> calendarCurrentPageDidChange")
    }
    
    
    private func generateImage(text: String, backgroundColor: UIColor, size: CGSize) -> UIImage? {
        if text.isEmpty { return nil }
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        let contenxt = UIGraphicsGetCurrentContext()
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: size.width, height: size.height), cornerRadius: 5)
        contenxt?.addPath(path.cgPath)
        contenxt?.setFillColor(UIColor.orange.cgColor)
        contenxt?.fillPath()
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        let attStr = NSAttributedString(string: text, attributes:[NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12),
                                                                   NSAttributedStringKey.backgroundColor: backgroundColor,
                                                                   NSAttributedStringKey.foregroundColor: UIColor.white,
                                                                   NSAttributedStringKey.paragraphStyle: style])
        attStr.draw(in: rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}


// MARK: - FSCalendarDataSource
extension FBOfflineTrainClenderController: FSCalendarDataSource {
    func minimumDate(for calendar: FSCalendar) -> Date {
        var minComponent = DateComponents()
        minComponent.year = -2
        let minDate = gregorian.date(byAdding: minComponent, to: Date())!
        return minDate
    }
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        var maxComponent = DateComponents()
        maxComponent.year = 2
        let maxDate = gregorian.date(byAdding: maxComponent, to: Date())!
        return maxDate
    }
}


// MARK: - UIGestureRecognizerDelegate
extension FBOfflineTrainClenderController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let shouldBegin = self.tableView.contentOffset.y <= -self.tableView.contentInset.top
        if shouldBegin {
            let velocity = self.scopeGesture.velocity(in: self.view)
            switch self.calendar.scope {
            case .month:
                return velocity.y < 0
            case .week:
                return velocity.y > 0
            }
        }
        return shouldBegin
    }
}



