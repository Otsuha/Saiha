//
//  SHContentSwitchSheetView.swift
//  Saiha
//
//  Created by 御前崎悠羽 on 2021/11/11.
//

import UIKit

@objc public protocol SHContentSwitchSheetViewDelegate {
    
    @objc optional func contentSwitchSheetView(_ contentSwitchSheetView: SHContentSwitchSheetView, didSwitchButtonStatusIn index: Int, with isOn: Bool)
    
}

open class SHContentSwitchSheetView: SHUIView, UITableViewDataSource {

    private var titleLabel: SHUILabel!
    private var switchContentView: SHUIView!
    private var mainTableView: UITableView!
    
    open var dataSource: [(icon: UIImage?, title: String, isOn: Bool)] = []
    
    open var defaultContentHeight: CGFloat {
        get {
            return self.tableViewHeight + CGFloat.saiha_verticalSize(num: 60)
        }
    }
    
    private var tableViewHeight: CGFloat {
        get {
            var height: CGFloat = 0
            if self.dataSource.count <= 8 {
                height = CGFloat(dataSource.count) * CGFloat.saiha_verticalSize(num: 56)
            } else {
                height = 8 * CGFloat.saiha_verticalSize(num: 56)
            }
            return height
        }
    }
    
    open weak var delegate: SHContentSwitchSheetViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.switchContentView = SHUIView()
        self.addSubview(self.switchContentView)
        self.switchContentView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        self.mainTableView = UITableView()
        self.mainTableView.register(SHContentSwitchSheetCell.self, forCellReuseIdentifier: "SHContentSwitchSheetCell")
        self.mainTableView.dataSource = self
        self.mainTableView.rowHeight = CGFloat.saiha_verticalSize(num: 56)
        self.mainTableView.separatorColor = UIColor.saiha_colorWithHexString("#D8D8D8", alpha: 0.5)
        self.mainTableView.separatorInset = UIEdgeInsets(top: 0, left: CGFloat.saiha_horizontalSize(num: 16), bottom: 0, right: CGFloat.saiha_horizontalSize(num: -18))
        self.switchContentView.addSubview(self.mainTableView)
        self.mainTableView.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(0)
        }
        
        self.titleLabel = SHUILabel()
        self.titleLabel.text = "照片上传"
        self.titleLabel.font = .systemFont(ofSize: CGFloat.saiha_verticalSize(num: 16), weight: .medium)
        self.switchContentView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(CGFloat.saiha_horizontalSize(num: 20))
            make.bottom.equalTo(self.mainTableView.snp.top).offset(CGFloat.saiha_verticalSize(num: -20))
            make.width.greaterThanOrEqualTo(CGFloat.saiha_horizontalSize(num: 64))
            make.height.equalTo(CGFloat.saiha_verticalSize(num: 20))
        }
        
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    open func setTitle(text: String) {
        self.titleLabel.text = text
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        self.mainTableView.snp.updateConstraints { make in
            make.height.equalTo(self.tableViewHeight)
        }
    }
    
    public static func show(title: String, dataSource: [(icon: UIImage?, title: String, isOn: Bool)], delegate: SHContentSwitchSheetViewDelegate? = nil, contentHeight: CGFloat? = nil, completionHandler: (() -> Void)?) {
        let sheetView: SHContentSwitchSheetView = SHContentSwitchSheetView()
        sheetView.setTitle(text: title)
        sheetView.delegate = delegate
        sheetView.dataSource = dataSource
        SHContentSheetView.show(customView: sheetView, contentHeight: sheetView.defaultContentHeight, completionHandler: completionHandler)
    }
    
    // MARK: - UITableViewDataSource.
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SHContentSwitchSheetCell = tableView.dequeueReusableCell(withIdentifier: "SHContentSwitchSheetCell", for: indexPath) as! SHContentSwitchSheetCell
        cell.switchButton.isOn = self.dataSource[indexPath.row].isOn
        cell.titleLabel.text = self.dataSource[indexPath.row].title
        if let image = self.dataSource[indexPath.row].icon {
            cell.showIcon = true
            cell.iconImageView?.image = image
        } else {
            cell.showIcon = false
        }
        cell.handleSwitch = { [weak self] switchButton in
            guard let strongSelf = self else { return }
            strongSelf.dataSource[indexPath.row].isOn = switchButton.isOn
        }
        return cell
    }
    
}

// MARK: - SHContentSwitchSheetCell.

open class SHContentSwitchSheetCell: UITableViewCell {
    
    open var iconImageView: UIImageView?
    open var titleLabel: SHUILabel!
    open var switchButton: UISwitch!
    
    open var showIcon: Bool = true
    
    open var handleSwitch: ((_ switchButton: UISwitch) -> Void)?
    
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        if self.showIcon {
            self.iconImageView = UIImageView()
            self.iconImageView?.contentMode = .scaleAspectFit
            self.contentView.addSubview(self.iconImageView!)
            self.iconImageView?.snp.makeConstraints({ make in
                make.left.equalToSuperview().offset(CGFloat.saiha_horizontalSize(num: 20))
                make.centerY.equalToSuperview()
                make.width.height.equalTo(CGFloat.saiha_verticalSize(num: 24))
            })
            
            self.titleLabel = SHUILabel()
            self.titleLabel.text = "中通快递"
            self.titleLabel.font = .systemFont(ofSize: CGFloat.saiha_verticalSize(num: 16))
            self.contentView.addSubview(self.titleLabel)
            self.titleLabel.snp.makeConstraints { make in
                make.left.equalTo(self.iconImageView!.snp.right).offset(CGFloat.saiha_horizontalSize(num: 8))
                make.centerY.equalToSuperview()
                make.width.greaterThanOrEqualTo(CGFloat.saiha_horizontalSize(num: 64))
            }
        } else {
            self.titleLabel = SHUILabel()
            self.titleLabel.text = "中通快递"
            self.titleLabel.font = .systemFont(ofSize: CGFloat.saiha_verticalSize(num: 16))
            self.contentView.addSubview(self.titleLabel)
            self.titleLabel.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(CGFloat.saiha_horizontalSize(num: 20))
                make.centerY.equalToSuperview()
                make.width.height.equalTo(CGFloat.saiha_verticalSize(num: 64))
            }
        }
        self.switchButton = UISwitch()
        self.switchButton.isOn = true
        self.switchButton.onTintColor = UIColor.saiha_colorWithHexString("#3951C4")
        self.switchButton.addTarget(self, action: #selector(self.handleSwitch(sender:)), for: .touchUpInside)
        self.contentView.addSubview(self.switchButton)
        self.switchButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(CGFloat.saiha_verticalSize(num: -24))
            make.centerY.equalToSuperview()
            make.width.equalTo(CGFloat.saiha_horizontalSize(num: 51))
        }
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @objc private func handleSwitch(sender: UISwitch) {
        sender.isOn = !sender.isOn
        self.handleSwitch?(sender)
    }
}
