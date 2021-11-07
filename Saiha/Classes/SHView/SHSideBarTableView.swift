//
//  SHSideBarTableView.swift
//  Saiha
//
//  Created by 御前崎悠羽 on 2021/11/7.
//

import UIKit

// MARK: - SHSideBarHeaderView.

open class SHSideBarHeaderView: UIView {
    
    open var titleLabel: UILabel?
    open var accessButton: UIButton?
    
    open var touchAccessButtonHandle: ((_ button: UIButton) -> Void)?
    
    private func initialize() {
        self.titleLabel = UILabel()
        self.titleLabel!.font = .systemFont(ofSize: CGFloat.saiha.verticalSize(num: 16))
        self.titleLabel!.textAlignment = .left
        self.addSubview(titleLabel!)
        self.titleLabel!.snp.remakeConstraints { make in
            make.left.equalToSuperview().offset(CGFloat.saiha.levelSize(num: 16))
            make.centerY.equalToSuperview()
            make.width.greaterThanOrEqualTo(CGFloat.saiha.levelSize(num: 64))
        }
        
        self.accessButton = UIButton()
        self.accessButton!.setImage(UIImage(named: "camera_add"), for: .normal)
        self.accessButton!.setImage(UIImage(named: "camera_add"), for: .selected)
        self.accessButton!.isSelected = false
        self.accessButton!.addTarget(self, action: #selector(self.handleButton(sender:)), for: .touchUpInside)
        self.addSubview(self.accessButton!)
        self.accessButton!.snp.remakeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(CGFloat.saiha.levelSize(num: -12))
            make.width.equalTo(CGFloat.saiha.levelSize(num: 24))
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initialize()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func handleButton(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        self.touchAccessButtonHandle?(sender)
    }
}

// MARK: - SHSideBarTableView data.

extension SHSideBarTableView {
    
    public struct SHSideBarDataCellModel {
        public let title: String?
        public let detail: String?
        public let image: UIImage?
        
        public init(title: String?, detail: String?, image: UIImage?) {
            self.title = title
            self.detail = detail
            self.image = image
        }
    }
    
    public struct SHSideBarDataModel {
        public let header: String
        public let contents: [SHSideBarDataCellModel]
        
        public var isSelected: Bool = false
        
        public init(header: String, contents: [SHSideBarDataCellModel]) {
            self.header = header
            self.contents = contents
        }
    }
}

// MARK: - SHSideBarTableViewDelegate.

@objc public protocol SHSideBarTableViewDelegate {
    
    @objc optional func sidebarTableView(_ sidebarTableView: SHSideBarTableView, viewForHeaderInSection section: Int) -> SHUIView?
}

// MARK: - SHSideBarTableView.

open class SHSideBarTableView: SHUIView {

    open var customHeaderView: SHSideBarHeaderView?
    open var customCellView: UIView?
        
    open var models: [SHSideBarTableView.SHSideBarDataModel] = []
    
    open weak var delegate: SHSideBarTableViewDelegate?
    
    open var headerHeight: CGFloat = CGFloat.saiha.verticalSize(num: 56)
    open var rowHeight: CGFloat = CGFloat.saiha.verticalSize(num: 56)
    
    open var dataSourceHandle: ((_ cell: UITableViewCell, _ indexPath: IndexPath) -> Void)?
    
    private var sidebarTableView: SHUITableView!
    
    private func initialize() {
        self.sidebarTableView = SHUITableView(frame: CGRect.zero, style: .grouped)
        self.sidebarTableView.register(UITableViewCell.self, forCellReuseIdentifier: "SideBarCell")
        self.sidebarTableView.rowHeight = self.rowHeight
        self.sidebarTableView.delegate = self
        self.sidebarTableView.dataSource = self
        self.addSubview(self.sidebarTableView)
        self.sidebarTableView.snp.remakeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UITableViewDataSource.

extension SHSideBarTableView: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.models[section].isSelected {
            return self.models[section].contents.count
        } else {
            return 0
        }
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return self.models.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "SideBarCell", for: indexPath)
        self.dataSourceHandle?(cell, indexPath)
        return cell
    }
}

// MARK: - UITableViewDelegate.

extension SHSideBarTableView: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.rowHeight
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView: SHSideBarHeaderView = SHSideBarHeaderView()
        headerView.titleLabel?.text = self.models[section].header
        headerView.touchAccessButtonHandle = { button in
            self.models[section].isSelected = !self.models[section].isSelected
            let sets: IndexSet = IndexSet(integer: section)
            tableView.reloadSections(sets, with: .fade)
        }
        return headerView
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.headerHeight
    }
}
