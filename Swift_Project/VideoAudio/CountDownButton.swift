//
//  CountDownButton.swift
//  Swift_Project
//
//  Created by HongpengYu on 2018/8/13.
//  Copyright © 2018 HongpengYu. All rights reserved.
//

import UIKit


class  CountdownButton: UIButton {
    var maxSecond = 60
    var countdown = false {
        didSet {
            if oldValue != countdown {
                countdown ? startCountdown() : stopCountdown()
            }
        }
    }
    
    private var second = 0
    private var timer: Timer?
    
    private var timeLabel: UILabel!
    private var normalText: String!
    private var normalTextColor: UIColor!
    private var disabledText: String!
    private var disabledTextColor: UIColor!
    
    // MARK: - Override
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        timeLabel.frame = bounds
        
    }
    
    // MARK: Setups
    
    private func setupLabel() {
        normalText = title(for: .normal) ?? ""
        disabledText = title(for: .disabled) ?? ""
        normalTextColor = titleColor(for: .normal) ?? UIColor.appTheme()
        disabledTextColor = titleColor(for: .disabled) ?? UIColor.appTheme()
        let  normalTitle = self.generateTimeString(withCurrentSecond: maxSecond)
        normalText = normalTitle
        setTitle("", for: .normal)
        setTitle("00:00", for: .disabled)
        timeLabel = UILabel()
        timeLabel.textAlignment = .center
        timeLabel.font = titleLabel?.font
        timeLabel.textColor = normalTextColor
        timeLabel.text = normalText
        addSubview(timeLabel)
    }
    
    // MARK: Private
    
    private func startCountdown() {
        second = maxSecond
        updateDisabled()
        
        if timer != nil {
            timer!.invalidate()
            timer = nil
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCountdown), userInfo: nil, repeats: true)
    }
    
    private func stopCountdown() {
        timer?.invalidate()
        timer = nil
        updateNormal()
    }
    
    private func updateNormal() {
        isEnabled = true
        timeLabel.textColor = normalTextColor
        timeLabel.text = normalText
    }
    
    private func updateDisabled() {
        isEnabled = false
        timeLabel.textColor = disabledTextColor
        timeLabel.text = self.generateTimeString(withCurrentSecond: second)
    }
    
    private func updateTitle() {
        isEnabled = false
        var components = DateComponents()
        components.second = Int(second)
        timeLabel.text = dateComponentsFormatter.string(for: components)
        timeLabel.textColor = UIColor.red
        timeLabel.backgroundColor = .cyan
    }
    
    @objc private func updateCountdown() {
        second -= 1
        updateTitle()
//        if second <= 0 {
//            countdown = false
//        } else {
//            updateDisabled()
//        }
    }
    
    private func generateTimeString(withCurrentSecond second: Int) ->String {
        var components = DateComponents()
        components.second = Int(second)
        return dateComponentsFormatter.string(for: components) ?? ""
    }
    
    private lazy var dateComponentsFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
//        formatter.zeroFormattingBehavior = .pad
        formatter.allowedUnits = [.minute, .second]
        return formatter
    }()
    
    
    deinit {
        countdown = false
    }
}
