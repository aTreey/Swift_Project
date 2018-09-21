//
//  AudioRecorderHUD.swift
//  Swift_Project
//
//  Created by HongpengYu on 2018/8/7.
//  Copyright © 2018 HongpengYu. All rights reserved.
//

import UIKit

protocol AudioRecorderHUDDelegate {
    func startAudioRecorder(_ button: UIButton)
    func closedAudioRecorder()
    
}

class AudioRecorderHUD: UIView {
    
    let hudHeight: CGFloat = 140.0
    
    var delegate: AudioRecorderHUDDelegate?
    
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Public
    
    func show(_ view: UIView) {
        self.containerView.frame = CGRect(x: 0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width + hudHeight , height: hudHeight)
        UIView.animate(withDuration: 0.3, animations: {
            self.backgroundButton.alpha = 1.0
            let frame = self.containerView.frame.offsetBy(dx: 0, dy: -self.hudHeight)
            self.containerView.frame = frame
        }, completion: nil)
        view.addSubview(self)
    }
    
    // MARK: - Private
    
    private func setupUI() {
        addSubview(backgroundButton)
        addSubview(containerView)
        containerView.addSubview(recorderButton)
        containerView.addSubview(stateLabel)
        containerView.addSubview(closedButton)
        containerView.addSubview(timeButton)
        
        timeButton.layer.borderWidth = UIScreen.main.scale * 0.5
        timeButton.layer.cornerRadius = 17
        timeButton.setTitleColor(UIColor.appTheme(), for: .normal)
        
        backgroundButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        containerView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(hudHeight)
        }
        
        recorderButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(18)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(CGSize(width: 64, height: 64))
        }
        
        closedButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
            $0.size.equalTo(CGSize(width: 26, height: 26))
        }
        
        timeButton.snp.makeConstraints {
            $0.centerY.equalTo(recorderButton)
            $0.leading.equalTo(recorderButton.snp.trailing).offset(11)
            $0.size.equalTo(CGSize(width: 66, height: 34))
        }
        
        stateLabel.snp.makeConstraints {
            $0.centerX.equalTo(recorderButton)
            $0.top.equalTo(recorderButton.snp.bottom).offset(11)
        }
    }
    
    // MARK: - Action
    
    @objc
    func closedButtonAction() {
        dismiss()
        self.delegate?.closedAudioRecorder()
    }
    
    @objc
    func dismiss() {
        UIView.animate(withDuration: 0.3, animations: {
            let frame = self.containerView.frame.offsetBy(dx: 0, dy: +300)
            self.backgroundButton.alpha = 0
            self.containerView.frame = frame
        }) { (success) in
            self.removeFromSuperview()
        }
    }
    
    @objc
    func recorderAction(button: UIButton) {
        timeButton.maxSecond = 60
        timeButton.countdown = true
        self.delegate?.startAudioRecorder(button)
    }
    
    
    
    // MARK: - Lazy
    
    private lazy var timeButton = CountdownButton()
    
    private lazy var stateLabel: UILabel = {
        let stateLabel = UILabel()
        stateLabel.textColor = UIColor.appNormalText()
        stateLabel.text = "点击开始录音"
        stateLabel.textAlignment = .center
        stateLabel.font = UIFont.systemFont(ofSize: 14)
        return stateLabel
    }()
    
    private lazy var recorderButton: UIButton = {
        let recorderButton = UIButton(type: .custom)
        recorderButton.setImage(UIImage(named: "icon_cat"), for: .normal)
        recorderButton.addTarget(self, action: #selector(recorderAction(button:)), for: .touchUpInside)
        recorderButton.backgroundColor = UIColor.appTheme()
        recorderButton.layer.cornerRadius = 32
        return recorderButton
    }()
    
    private lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = UIColor.appWhite()
        return containerView
    }()
    
    private lazy var closedButton: UIButton = {
        let closedButton = UIButton(type: .custom)
        closedButton.setImage(UIImage(named: "icon_cat"), for: .normal)
        closedButton.addTarget(self, action: #selector(closedButtonAction), for: .touchUpInside)
        return closedButton
    }()
    
    private lazy var backgroundButton: UIButton = {
        let backgroundButton = UIButton(type: .custom)
        backgroundButton.backgroundColor = UIColor.appBlackText().withAlphaComponent(0.5)
        backgroundButton.isEnabled = false
        return backgroundButton
    }()
}
