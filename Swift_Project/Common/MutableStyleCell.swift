//
//  MutableStyleCell.swift
//  Swift_Project
//
//  Created by HongpengYu on 2018/7/21.
//  Copyright © 2018年 HongpengYu. All rights reserved.
//

import UIKit
import SnapKit

// MARK: -
// MARK: - 通过协议扩展注册cell复用cell 测试
class TableProtocolCell: UITableViewCell, ReusableView {
    //    override var reuseIdentifier: String? {
    //        return "cell"
    //    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .cyan
        self.textLabel?.text = "通过协议和泛型创建的cell"
        self.textLabel?.textColor = .blue
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        view.backgroundColor = UIColor(hex: "#000000").withAlphaComponent(0.4)
        let label = UILabel()
        label.text = "测试alpha"
        label.backgroundColor = UIColor.orange
        
        contentView.addSubview(view)
        view.addSubview(label)
        label.sizeToFit()
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - TableProtocolCell2
class TableProtocolCell2: UITableViewCell, ReusableView {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .red
        self.textLabel?.text = "cell1 - 通过协议和泛型创建的"
        self.textLabel?.textAlignment = .right
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        view.backgroundColor = UIColor(hue: 0, saturation: 0, brightness: 0, alpha: 0.4)
        let label = UILabel()
        label.text = "测试alpha222"
        label.backgroundColor = UIColor.orange
        
        contentView.addSubview(view)
        view.addSubview(label)
        label.sizeToFit()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// 测试协议cell
class BytesCountTitleCell: UITableViewCell, TitlePresentable, BytesCountPresentable, ReusableView {
    var bytesCountLabel: UILabel!
    var titleLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
    }
}



// MARK: -
// MARK: - View
class SwitchWithTitleCell: UITableViewCell, ReusableView {
    private var delegate: SwitchPresentable?
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(switchControl)
        
        nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20)
        nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        
        switchControl.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        switchControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 20)
    }
    
    func configure(delegate: SwitchPresentable) {
        self.delegate = delegate
        nameLabel.text = delegate.title
        switchControl.isOn = delegate.switchIsOn
        switchControl.onTintColor = (delegate as! SwitchControlViewModel).setSwitchColor()
    }
    
    
    // MARK: - Action
    @objc
    private func switchControlValueChanged(_ sender: UISwitch) {
        delegate?.switchControlChange(isOn: sender.isOn)
    }
    
    // MARK: - Lazy
    private lazy var switchControl: UISwitch = {
        let switchControl = UISwitch()
        switchControl.isOn = true
        switchControl.addTarget(self, action: #selector(switchControlValueChanged(_:)), for: .valueChanged)
        return switchControl
    }()
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont.systemFont(ofSize: 14)
        nameLabel.textAlignment = .left
        return nameLabel
    }()
}


// MARK: -
// MARK: - 分离数据源和代理
class SwitchWithTitleCell2: UITableViewCell, ReusableView {
    
    private var delegate: SwitchControlCellDelegate?
    private var dataSource: SwitchControlCellDataSource?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(switchControl)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        switchControl.translatesAutoresizingMaskIntoConstraints = false
        switchControl.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        switchControl.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
    }
    
    func configure(delegate: SwitchControlCellDelegate, dataSource: SwitchControlCellDataSource) {
        self.delegate = delegate
        self.dataSource = dataSource
        
        nameLabel.text = dataSource.title
        switchControl.isOn = dataSource.switchIsOn
        switchControl.onTintColor = delegate.switchColor
        nameLabel.sizeToFit()
    }
    
    
    // MARK: - Action
    @objc
    private func switchControlValueChanged(_ sender: UISwitch) {
        delegate?.switchControlChanged(isOn: sender.isOn)
    }
    
    // MARK: - Lazy
    private lazy var switchControl: UISwitch = {
        let switchControl = UISwitch()
        switchControl.isOn = true
        switchControl.addTarget(self, action: #selector(switchControlValueChanged(_:)), for: .valueChanged)
        return switchControl
    }()
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont.systemFont(ofSize: 14)
        nameLabel.textAlignment = .left
        return nameLabel
    }()
}


// MARK: - 课程图片cell

protocol PictureCellDelegate {
    func didSelectPicture(indexPath: IndexPath)
    func cancelPicture()
}

class PictureCell: UITableViewCell, ReusableView {
    
    var datas: [Int] = []
    var delegate: PictureCellDelegate?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        for i in 0..<9 {
            datas.append(i)
        }
        
        setupUI()
        
        
        // iOS 9 拖拽x实现 - 添加手势设置collectionView cell 可以重排版
        collectionView.addGestureRecognizer(longPressGesture)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(68)
            $0.trailing.equalToSuperview().offset(-27)
            $0.bottom.equalToSuperview().priority(.low)
            $0.height.equalTo((UIScreen.main.bounds.width + 2 * 8) / 3.0 * 3)
        }
    }
    
    
    // MARK: - iOS 9 长按拖拽
    @objc
    private func longPress(gesture: UILongPressGestureRecognizer) {
        let touchPoint = gesture.location(in: collectionView)
        switch gesture.state {
        case .began:
            // 获取选中的索引
            guard let selectIndexPath = collectionView.indexPathForItem(at: touchPoint) else {
                return
            }
            collectionView.beginInteractiveMovementForItem(at: selectIndexPath)
        case .changed:
            collectionView.updateInteractiveMovementTargetPosition(touchPoint)
        case .ended:
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()
        }
    }
    
    
    
    // MARK: - Lazy
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
        collectionView.register(DragCell.self, forCellWithReuseIdentifier: DragCell.cellIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        // iOS 11 拖拽
        /*
        if #available(iOS 11, *) {
            collectionView.dragInteractionEnabled = true
            collectionView.dragDelegate = self
            collectionView.dropDelegate = self
        }
        */
        return collectionView
    }()
    
    private lazy var longPressGesture: UILongPressGestureRecognizer = {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPress(gesture:)))
        return longPressGesture
    }()
}

// MARK: - UICollectionViewDataSource
extension PictureCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DragCell.cellIdentifier, for: indexPath) as! DragCell
        cell.titleLabel.text = String(indexPath.row)
        cell.delegate = self
        return cell
    }
    
    
    // iOS 9 拖拽
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    // iOS 9 拖拽后更新数据源
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        guard datas != nil  else { return }
        let sourceItem = datas[sourceIndexPath.item]
        collectionView.performBatchUpdates({
            datas.remove(at: sourceIndexPath.item)
            datas.insert(sourceItem, at: destinationIndexPath.item)
            collectionView.moveItem(at: destinationIndexPath, to: sourceIndexPath)
        }, completion: nil)
    }
    
}

// MARK: - 设置UICollectionViewDelegateFlowLayout
extension PictureCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 2 * 8) / 3.0
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(4, 0, 4, 0)
    }
}


extension PictureCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.didSelectPicture(indexPath: indexPath)
    }
}


extension PictureCell: DragCellDelegate {
    func cancelButtonAction(cell: DragCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else {return}
        collectionView.performBatchUpdates({
            print(indexPath)
            collectionView.deleteItems(at: [indexPath])
            self.datas.remove(at: indexPath.item)
        }, completion: nil)
    }
    
}

// MARK: - iOS 11 拖拽
/*
@available(iOS 11.0, *)

extension PictureCell: UICollectionViewDragDelegate {
    // 拖动item
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let item = datas?[indexPath.item]
        let itemProvider = NSItemProvider(object: String(item!) as NSItemProviderWriting)
        let drapItem = UIDragItem(itemProvider: itemProvider)
        return [drapItem]
    }
    
    // 拖动时预览
    
    func collectionView(_ collectionView: UICollectionView, dragPreviewParametersForItemAt indexPath: IndexPath) -> UIDragPreviewParameters? {
        guard (!indexPath.isEmpty) else {return nil}
        let previewParameters = UIDragPreviewParameters()
        let cell = collectionView.cellForItem(at: indexPath)
        previewParameters.visiblePath = UIBezierPath(roundedRect: (cell!.bounds), cornerRadius: 10)
        return previewParameters
    }
}

// MARK: - iOS 11 拖动item

@available(iOS 11.0, *)
extension PictureCell: UICollectionViewDropDelegate {
    // 是否接受拖拽
    func collectionView(_ collectionView: UICollectionView, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: NSString.self)
    }
    // 显示拖拽时的位置
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        
        var dropProposal = UICollectionViewDropProposal(operation: .cancel)
        // 同一个APP中拖拽
        if (session.localDragSession != nil) {
            dropProposal = UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
            return dropProposal
        }
        return dropProposal
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        
        if coordinator.items.count == 1, let sourceIndexPath = coordinator.items.first?.sourceIndexPath {
            let destinationIndexPath = coordinator.destinationIndexPath!
            // 多条数据删除插入时同时执行动画
            collectionView.performBatchUpdates({
                guard let sourceItem = coordinator.items.first?.dragItem.localObject as? Int else {return}
                datas!.remove(at: sourceItem)
                datas!.insert(sourceItem, at: destinationIndexPath.item)
                collectionView .moveItem(at: sourceIndexPath, to: destinationIndexPath)
            }) { (finished) in
                
            }
            
            // 动画形式移动cell
            coordinator.drop(coordinator.items.first!.dragItem, toItemAt: destinationIndexPath)
        }
    }
}
*/

// MARK: - 插入内容Cell
@objc
protocol SelectItemCellDelegate {
    func clickAction(sender: UIButton)
}

class SelectItemCell: UITableViewCell, ReusableView {
    weak var delegate: SelectItemCellDelegate?
    private var buttons: [UIButton]?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupConstraints() {
        
    }
    
    private func setupUI() {
        let titles = ["拍照", "相册", "录音", "连接"]
        let images = ["icon_cat", "icon_cat", "icon_cat", "icon_cat"];
        var tempButton: UIButton?
        for index in 0..<titles.count {
            let button = UIButton(type: .custom)
            button.setTitle(titles[index], for: .normal)
            button.setTitleColor(UIColor.black, for: .normal)
            button.setImage(UIImage(named: images[index]), for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            button.backgroundColor = UIColor(red: CGFloat((arc4random() % 255)) / 255, green: CGFloat((arc4random() % 255)) / 255, blue: CGFloat((arc4random() % 255)) / 255, alpha: 1.0)
            button.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
            contentView.addSubview(button)
            buttons?.append(button)
            
            button.snp.makeConstraints {
                $0.size.equalTo(CGSize(width: 50, height: 50))
                $0.centerY.equalTo(contentView)
                $0.bottom.equalToSuperview().priority(.low)
                $0.left.equalTo(index == 0 ?  contentView.snp.left : (tempButton!.snp.right))
            }
            tempButton = button
            button.setTitleAndImagePosition(style: .top)
        }
    }
    
    // MARK: - Action
    @objc
    func buttonAction(sender: UIButton) {
        self.delegate?.clickAction(sender: sender)
    }
}

// MARK: - 🔗cell
class LinkCell: UITableViewCell, ReusableView {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
        
        iconImageView.snp.makeConstraints {
            $0.size.equalTo(CourseCell.courseImageSize)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(CourseCell.courseImageEdges.left)
            $0.top.equalToSuperview().offset(CourseCell.courseImageEdges.top).priority(.low)
            $0.bottom.equalToSuperview().offset(-CourseCell.courseImageEdges.bottom).priority(.low)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(iconImageView)
            $0.leading.equalTo(iconImageView.snp.trailing).offset(CourseCell.labelMargin)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.bottom.equalTo(iconImageView)
            $0.leading.equalTo(iconImageView.snp.trailing).offset(CourseCell.labelMargin)
        }
        
    }
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textAlignment = .left
        titleLabel.text = "连接标题"
        return titleLabel
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let subTitleLabel = UILabel()
        subTitleLabel.font = UIFont.systemFont(ofSize: 14)
        subTitleLabel.textAlignment = .left
        subTitleLabel.text = "连接副标题"
        return subTitleLabel
    }()
    
    private lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.image = UIImage(named: "icon_cat")
        return iconImageView
    }()
    
}

// MARK: - AudioRecorder Cell

protocol AudioRecorderCellDelegate {
    func playButtonOnClick(_ cell: AudioRecorderCell)
}

class AudioRecorderCell: UITableViewCell, ReusableView {
    
    var delegate: AudioRecorderCellDelegate?
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    private func setupUI() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(playButton)
        
        iconImageView.snp.makeConstraints {
            $0.size.equalTo(CourseCell.courseImageSize)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(CourseCell.courseImageEdges.left)
            $0.top.equalToSuperview().offset(CourseCell.courseImageEdges.top).priority(.low)
            $0.bottom.equalToSuperview().offset(-CourseCell.courseImageEdges.bottom).priority(.low)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(iconImageView)
            $0.leading.equalTo(iconImageView.snp.trailing).offset(CourseCell.labelMargin)
        }
        
        playButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-20)
            $0.size.equalTo(CGSize(width: 50, height: 50))
            $0.centerY.equalToSuperview()
        }
        playButton.setTitleAndImagePosition(style: .top)
    }
    
    
    // MARK: - Action
    @objc
    private func playButtonAction() {
        self.delegate?.playButtonOnClick(self)
    }
    
    
    // MARK: - Lazy
    private lazy var playButton: UIButton = {
        let playButton = UIButton(type: .custom)
        playButton.setTitle("播放", for: .normal)
        playButton.setTitleColor(UIColor.black, for: .normal)
        playButton.setImage(UIImage(named: "icon_cat"), for: .normal)
        playButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        playButton.backgroundColor = UIColor(red: CGFloat((arc4random() % 255)) / 255, green: CGFloat((arc4random() % 255)) / 255, blue: CGFloat((arc4random() % 255)) / 255, alpha: 1.0)
        playButton.addTarget(self, action: #selector(playButtonAction), for: .touchUpInside)
        return playButton
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textAlignment = .left
        titleLabel.text = "录音 1"
        return titleLabel
    }()
    
    private lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.image = UIImage(named: "icon_cat")
        iconImageView.backgroundColor = UIColor.purple
        return iconImageView
    }()
}


