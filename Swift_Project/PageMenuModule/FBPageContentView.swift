//
//  PageContentView.swift
//  Swift_Project
//
//  Created by HongpengYu on 2018/7/3.
//  Copyright © 2018年 HongpengYu. All rights reserved.
//

import UIKit

class FBPageContentView: UIView {
    
    var items = [String]()
    
    var didSelectIndexClosure: ((IndexPath) -> ())?
    
    var contentHeaderView: UIView?
    private var config = FBPageViewConfig()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    convenience init(frame: CGRect, items: [String], config: FBPageViewConfig = FBPageViewConfig()) {
        self.init(frame: frame)
        self.items = items
        self.config = config
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    private func setupUI() {
        addSubview(titleView)
        addSubview(collectionView)
        
        let size = CGSize(width: UIScreen.main.bounds.width, height: config.titleViewHeight)
        titleView.snp.makeConstraints {
            $0.size.equalTo(size)
            if #available(iOS 11.0, *) {
                $0.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            } else {
                // Fallback on earlier versions
                $0.top.equalTo(64)
            }
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom)
            $0.leading.bottom.trailing.equalToSuperview()
        }
        
        titleView.delegate = self
        titleView.titleArray = items
    }
    
    
    // MARK: - Lazy
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 64 - config.titleViewHeight)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .green
        collectionView.isPagingEnabled = true
        collectionView.register(FBPageContentCell.self, forCellWithReuseIdentifier: FBPageContentCell.cellIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private lazy var titleView: PageTitleView = PageTitleView()
}

extension FBPageContentView: FBPageTitleViewDelegate {
    func pageTitleView(_ pageTitleView: PageTitleView, didSelect index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
        collectionView.reloadData()
    }
}

extension FBPageContentView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FBPageContentCell.cellIdentifier, for: indexPath) as! FBPageContentCell
        cell.didSelectTableViewCellClosure = { (indexPath) in
            self.didSelectIndexClosure?(indexPath)
        }
        //TODO: 传入数据
//        cell.items = items[indexPath.item].
        return cell
    }
}

extension FBPageContentView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let scrollViewWidth = scrollView.frame.width
        let index = Int(scrollView.contentOffset.x / scrollViewWidth)
        titleView.updateState(selectIndex: index)
    }
}

class FBPageContentCell: UICollectionViewCell {
    var didSelectTableViewCellClosure: ((IndexPath) -> ())?
    
    var items = [String]()
    
    static let cellIdentifier = "pageContentCell"
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        setup()
    }
    
    private func setup() {
        contentView.addSubview(tableView)
        items = ["测试0","测试1", "测试2", "测试3","测试4","测试5","测试6"]
        
        headerView.backgroundColor = UIColor.white
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(insets)
        }
    }
    
    convenience init(frame: CGRect, headerView: UIView?) {
        self.init(frame: frame)
        tableView.tableHeaderView = headerView
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Lazy
    private let headerViewFrame = CGRect(origin: CGPoint.zero, size: CGSize(width: UIScreen.main.bounds.width, height: 132))
    private lazy var headerView: PageContentHeaderView = PageContentHeaderView(frame: headerViewFrame)
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .gray
        tableView.register(FBStudyPlainCell.self, forCellReuseIdentifier: FBStudyPlainCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 130
        tableView.separatorStyle = .none
        tableView.tableHeaderView = headerView
        return tableView
    }()
}

extension FBPageContentCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FBStudyPlainCell.identifier, for: indexPath)
        return cell
    }
}

extension FBPageContentCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectTableViewCellClosure?(indexPath)
    }
}
