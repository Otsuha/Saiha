//
//  SHSideBarTableView.swift
//  Saiha
//
//  Created by 御前崎悠羽 on 2021/11/7.
//

import UIKit

// MARK: - SHSideBarHeaderView.

open class SHSideBarHeaderView: SHUIView {
    
    open var titleLabel: UILabel?
    open var accessButton: UIButton?
    
    open var touchAccessButtonHandle: ((_ button: UIButton) -> Void)?
    
    private func initialize() {
        self.accessButton = UIButton()
        self.accessButton!.setImage(UIImage(named: "arrow_down"), for: .normal)
        self.accessButton!.setImage(UIImage(named: "arrow_up"), for: .selected)
        self.accessButton!.isSelected = false
        self.accessButton!.addTarget(self, action: #selector(self.handleButton(sender:)), for: .touchUpInside)
        self.addSubview(self.accessButton!)
        self.accessButton!.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(CGFloat.saiha.horizontalSize(num: -12))
            make.width.equalTo(CGFloat.saiha.horizontalSize(num: 24))
        }
        
        self.titleLabel = UILabel()
        self.titleLabel!.font = .systemFont(ofSize: CGFloat.saiha.verticalSize(num: 16))
        self.titleLabel!.textAlignment = .left
        self.addSubview(titleLabel!)
        self.titleLabel!.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(CGFloat.saiha.horizontalSize(num: 16))
            make.centerY.equalToSuperview()
            make.right.lessThanOrEqualTo(self.accessButton!.snp.left).offset(CGFloat.saiha.horizontalSize(num: -42))
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
    
    @objc optional func sidebarTableView(_ sidebarTableView: SHSideBarTableView, viewForHeaderInSection section: Int) -> SHSideBarHeaderView?
}

// MARK: - SHSideBarTableView.

open class SHSideBarTableView: SHUIView {
        
    open var models: [SHSideBarTableView.SHSideBarDataModel] = []
    
    open weak var delegate: SHSideBarTableViewDelegate?
    
    open var headerHeight: CGFloat = CGFloat.saiha.verticalSize(num: 56)
    open var rowHeight: CGFloat = CGFloat.saiha.verticalSize(num: 56)
    
    open var dataSourceHandle: ((_ cell: UITableViewCell, _ indexPath: IndexPath) -> Void)?
    
    open var cellSeparatorStyle: UITableViewCell.SeparatorStyle = .none {
        willSet {
            self.sidebarTableView.separatorStyle = newValue
        }
    }
    open var cellSeparatorColor: UIColor = UIColor.saiha.colorWithHexString("#D8D8D8", alpha: 0.5) {
        willSet {
            self.sidebarTableView.separatorColor = newValue
        }
    }
    
    private var sidebarTableView: SHUITableView!
    
    private func initialize() {
        self.sidebarTableView = SHUITableView(frame: CGRect.zero, style: .grouped)
        self.sidebarTableView.register(UITableViewCell.self, forCellReuseIdentifier: "SideBarCell")
        self.sidebarTableView.rowHeight = self.rowHeight
        self.sidebarTableView.delegate = self
        self.sidebarTableView.dataSource = self
        self.sidebarTableView.sectionHeaderHeight = 0
        self.sidebarTableView.sectionFooterHeight = 0
        self.sidebarTableView.separatorStyle = .none
        self.sidebarTableView.separatorColor = self.cellSeparatorColor
        self.addSubview(self.sidebarTableView)
        self.sidebarTableView.snp.makeConstraints { make in
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
    
    open func reloadSections(_ sets: [Int], with animation: UITableView.RowAnimation) {
        let isets: IndexSet = IndexSet(sets)
        self.sidebarTableView.reloadSections(isets, with: animation)
    }
    
    open func ee() {
        self.sidebarTableView.separatorStyle = .none
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
        let delegateHeaderView: SHSideBarHeaderView? = self.delegate?.sidebarTableView?(self, viewForHeaderInSection: section)
        if delegateHeaderView == nil {
            let headerView: SHSideBarHeaderView = SHSideBarHeaderView()
            headerView.titleLabel?.text = self.models[section].header
            headerView.accessButton?.isSelected = self.models[section].isSelected
            headerView.touchAccessButtonHandle = { button in
                self.models[section].isSelected = button.isSelected
                let sets: IndexSet = IndexSet(integer: section)
                tableView.reloadSections(sets, with: .fade)
            }
            return headerView
        } else {
            return delegateHeaderView
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.headerHeight
    }
}
