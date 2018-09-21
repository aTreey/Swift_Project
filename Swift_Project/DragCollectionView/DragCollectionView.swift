//
//  DragCollectionView.swift
//  Swift_Project
//
//  Created by HongpengYu on 2018/8/8.
//  Copyright © 2018 HongpengYu. All rights reserved.
//

import UIKit

class DragView: UICollectionView {
    
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(16, 16, 16, 16)
        layout.minimumInteritemSpacing = 8
        layout.itemSize = CGSize(width: 60, height: 60)
        layout.scrollDirection = .horizontal
        return layout
    }()
}


protocol DragCellDelegate {
    func cancelButtonAction(cell: DragCell)
    
}
class DragCell: UICollectionViewCell {
    static let cellIdentifier = "collectionCellIdentifier"
    var delegate: DragCellDelegate?
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.backgroundColor = .cyan
        return titleLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.orange
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(pictureImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(closedButton)
        
        pictureImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        closedButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
            $0.size.equalTo(CGSize(width: 26, height: 26))
        }
        
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
    }
    
    // MARK: - Action
    @objc
    func closedButtonAction() {
        self.delegate?.cancelButtonAction(cell: self)
    }
    
    private lazy var closedButton: UIButton = {
        let closedButton = UIButton(type: .custom)
        closedButton.setImage(UIImage(named: "icon_cat"), for: .normal)
        closedButton.addTarget(self, action: #selector(closedButtonAction), for: .touchUpInside)
        return closedButton
    }()
    
    private lazy var pictureImageView: UIImageView = {
        let pictureImageView = UIImageView()
        pictureImageView.image = UIImage(named: "icon_cat")
        return pictureImageView
    }()
    
}
