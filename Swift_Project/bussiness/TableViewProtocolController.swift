//
//  TableViewProtocolController.swift
//  Swift_Project
//
//  Created by HongpengYu on 2018/7/19.
//  Copyright © 2018年 HongpengYu. All rights reserved.
//

import UIKit

// MARK: -
// MARK: - 使用协议扩展cell的注册和复用
class TableViewProtocolController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(T: TableProtocolCell.self)
        tableView.register(T: TableProtocolCell2.self)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if indexPath.row % 2 == 0 {
            cell = tableView.dequeueReusableCell(indexPath) as TableProtocolCell
        } else {
            cell = tableView.dequeueReusableCell(indexPath) as TableProtocolCell2
        }
        return cell
    }
}

// MARK: -
// MARK: - 使用协议返回指定的cell
class SettingsViewController: UITableViewController {
    // 设置类型
    enum Setting: Int {
        case setting1
        case setting2
        case setting3
        case setting4
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let setting = Setting(rawValue: indexPath.row) {
            switch setting {
            case .setting1:
                let cell = tableView.dequeueReusableCell(indexPath) as SwitchWithTitleCell
                let viewModel = SwitchControlViewModel()
                cell.configure(delegate: viewModel)
                return cell
            case .setting2:
                let cell = tableView.dequeueReusableCell(indexPath) as BytesCountTitleCell
                cell.textLabel?.text = "200M"
                return cell
            default:
                break;
            }
        }
        return tableView.dequeueReusableCell(indexPath) as TableProtocolCell
    }
    
    
    private func setup() {
        view.backgroundColor = UIColor.lightGray
        tableView.register(T: SwitchWithTitleCell.self)
        tableView.register(T: BytesCountTitleCell.self)
        tableView.register(T: TableProtocolCell.self)
    }
}

// MARK: -
// MARK: - 使用协议分离dataSource 和delegate 后 TableViewController
class SettingsViewController2: UITableViewController {
    // 设置类型
    enum Setting: Int {
        case setting1
        case setting2
        case setting3
        case selectItem
        case audioRecorder
        case link
        case picture
        
    }
    
    
    
    var datas: [Int] = []
    
    var recoder: AudioRecorderManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0...7 {
            datas.append(i)
        }
        
        setup()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80
        recorderHUD.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        player.stop()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let setting = Setting(rawValue: datas[indexPath.row]) {
            switch setting {
            case .setting1:
                let cell = tableView.dequeueReusableCell(indexPath) as SwitchWithTitleCell2
                let viewModel = SwitchControlViewModel2()
                cell.configure(delegate: viewModel, dataSource: viewModel)
                return cell
            case .setting2:
                let cell = tableView.dequeueReusableCell(indexPath) as BytesCountTitleCell
                cell.textLabel?.text = "200M"
                return cell
                
            case .audioRecorder:
                let cell = tableView.dequeueReusableCell(indexPath) as AudioRecorderCell
                return cell
                
            case .link:
                let cell = tableView.dequeueReusableCell(indexPath) as LinkCell
                return cell
                
            case .picture:
                let cell = tableView.dequeueReusableCell(indexPath) as PictureCell
                return cell
                
            case .selectItem:
                let cell = tableView.dequeueReusableCell(indexPath) as SelectItemCell
                cell.delegate = self
                return cell
            default:
                let cell = tableView.dequeueReusableCell(indexPath) as TableProtocolCell
                return cell
            }
        }
        return tableView.dequeueReusableCell(indexPath) as TableProtocolCell
    }
    
    
    private func setup() {
        view.backgroundColor = UIColor.lightGray
        tableView.register(T: SwitchWithTitleCell2.self)
        tableView.register(T: BytesCountTitleCell.self)
        tableView.register(T: TableProtocolCell.self)
        tableView.register(T: SelectItemCell.self)
        tableView.register(T: AudioRecorderCell.self)
        tableView.register(T: LinkCell.self)
        tableView.register(T: PictureCell.self)
    }
    
    private lazy var recorderHUD: AudioRecorderHUD = AudioRecorderHUD()
    private lazy var player = AudioPlayerManager()

}

extension SettingsViewController2: SelectItemCellDelegate {
    func clickAction(sender: UIButton) {
        switch sender.titleLabel?.text {
        case "拍照":
            print(sender.titleLabel?.text)
        case "相册":
            print(sender.titleLabel?.text)
        case "录音":
            recorderHUD.show(view)
        case "连接":
            setupAler()
        default:
            break
        }
    }
    
    private func setupAler() {
        let alert = UIAlertController(title: "生成链接", message: nil, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let action = UIAlertAction(title: "确定", style: .default) { (UIAlertAction) in
            guard let textField = alert.textFields?.first,
                let text = textField.text,
                !(text.isEmpty) else {
                return
            }
            
            let index = self.datas.index(after: Setting.link.rawValue)
            self.datas.insert(Setting.link.rawValue, at: index)
            self.tableView.reloadData()
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "请插入链接"
            textField.borderStyle = .none
            textField.clearButtonMode = .always
            textField.inputView = UIView()
        }
        alert.addAction(cancel)
        alert.addAction(action)
        
        if #available(iOS 9, *) {
            alert.preferredAction = action
        }
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension SettingsViewController2: AudioRecorderHUDDelegate {
    func startAudioRecorder(_ button: UIButton) {
//        let index = datas.index(after: Setting.audioRecorder.rawValue)
//        datas.insert(Setting.audioRecorder.rawValue, at: index)
//        tableView.reloadData()
        print(button.isSelected)
        recoder = AudioRecorderManager("test")
        recoder?.delegate = self
        recoder?.record(time: 60)
    }
    
    func closedAudioRecorder() {
        let url = recoder?.stop()
        let path = url?.components(separatedBy: "///").last
        ConvertAudioFile.conventToMp3(withCafFilePath: path, sampleRate: Int32(11025.0)) { (result, mp3FilePath) in
            print("result == \(result)----mp3FilePath == \(mp3FilePath)")
            let mp3fileUrl = URL(fileURLWithPath:mp3FilePath!)
            let data = try! Data(contentsOf: mp3fileUrl)
        }
        print(closedAudioRecorder)
    }
}


extension SettingsViewController2: AudioRecorderDelegate {
    func recorderEnded(url: URL?, error: Error?) {
        if let url = url, error == nil {
            player.play(url)
        }
    }
}
