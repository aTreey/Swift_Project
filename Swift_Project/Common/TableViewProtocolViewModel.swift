//
//  TableViewProtocolViewModel.swift
//  Swift_Project
//
//  Created by HongpengYu on 2018/8/2.
//  Copyright © 2018年 HongpengYu. All rights reserved.
//

import UIKit


// MARK: - 协议
/// 标题协议
protocol TitlePresentable {
    var titleLabel: UILabel! { get set }
    func setTitle(title: String?)
}

extension TitlePresentable {
    func setTitle(title: String?) {
        titleLabel.text = title
    }
}

/// 子标题协议
protocol SubTitlePresentable {
    var subTitleLabel: UILabel! { get set }
    func setSubTitle(title: String?)
}

extension SubTitlePresentable {
    func setSubTitle(title: String?) {
        subTitleLabel.text = title
    }
}

/// 字节数协议
protocol BytesCountPresentable {
    var bytesCountLabel: UILabel! { get set }
    func setBytesCount(bytesCount: Int)
}

extension BytesCountPresentable {
    func setBytesCount(bytesCount: Int) {
        bytesCountLabel.text = bytesCountString(bytesCount)
    }
    
    private func bytesCountString(_ bytesCount: Int) -> String {
        return "\(bytesCount)"
    }
}




// MARK: -
// MARK: - 使用协议ViewModel

/// 带有switch 协议
protocol SwitchPresentable {
    var title: String { get }
    var switchIsOn: Bool {  get  }
    func switchControlChange(isOn: Bool)
}

extension SwitchPresentable {
    /// 设置开关默认颜色
    func setSwitchColor() -> UIColor {
        return .yellow
    }
}

struct SwitchControlViewModel: SwitchPresentable {
    var title: String = "开关cell"
    var switchIsOn: Bool = true
    
    func switchControlChange(isOn: Bool) {
        if isOn {
            print("打开的")
        } else {
            print("关闭的")
        }
    }
    
    func setSwitchColor() -> UIColor {
        return .orange
    }
}



// MARK: -
// MARK: - 分离出cell 的数据源协议和委托协议
// MARK: - dataSource 协议
protocol SwitchControlCellDataSource {
    var title: String { get }
    var switchIsOn: Bool { get  }
}


// MARK: - delegate 协议
protocol SwitchControlCellDelegate {
    var textColor: UIColor { get }
    var switchColor: UIColor { get }
    var font: UIFont { get }
    
    func switchControlChanged(isOn: Bool)
}

// 默认实现
extension SwitchControlCellDelegate {
    var textColor: UIColor {
        return .purple
    }
    
    var switchColor: UIColor {
        return .orange
    }
    
    var font: UIFont {
        return UIFont.boldSystemFont(ofSize: 14)
    }
}


struct SwitchControlViewModel2: SwitchControlCellDataSource {
    var title: String = "cell代理和数据源分离后cell"
    var switchIsOn: Bool = false
}

extension SwitchControlViewModel2: SwitchControlCellDelegate {
    
    var switchColor: UIColor {
        return .blue
    }
    
    func switchControlChanged(isOn: Bool) {
        if isOn {
            print("cell2打开了开关")
        } else {
            print("cell2关闭了开关")
        }
    }
}
