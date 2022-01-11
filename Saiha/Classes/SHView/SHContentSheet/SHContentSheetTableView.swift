//
//  SHContentSheetTableView.swift
//  Saiha
//
//  Created by 河瀬雫 on 2021/12/23.
//

import UIKit
import SnapKit
import SDWebImage

open class SHContentSheetTableView: SHUIView {
    
    struct DataModel {
        var title: String = ""
        var iconURL: String?
        var isSelected: Bool = false
        var isOn: Bool = false
    }
    
    public enum Style {
        case `default`
        case multipleSelection
        case contentSwitch
    }
    
    var titleLabel: SHUILabel = {
        let label: SHUILabel = SHUILabel()
        label.font = .systemFont(ofSize: CGFloat.saiha_verticalSize(num: 16), weight: .medium)
        return label
    }()
    var cancelButton: SHUIButton = {
        let button: SHUIButton = SHUIButton()
        if #available(iOS 13.0, *) {
            button.setImage(UIImage(systemName: "xmark"), for: .normal)
            button.tintColor = UIColor.defaultLabelColor
        } else {
            button.setImage(UIImage.saiha_imageInSaihaBundle(name: "xmark"), for: .normal)
        }
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    var mainTableView: UITableView!
    
    var style: SHContentSheetTableView.Style!
    
    var dataSource: [SHContentSheetTableView.DataModel] = []
        
    var showTitleLabel: Bool = true
    var title: String? {
        willSet {
            self.titleLabel.text = newValue
            if newValue == nil {
                self.showTitleLabel = false
                Self.showCancelButton = false
            } else {
                self.showTitleLabel = true
                Self.showCancelButton = true
            }
        }
    }
    
    static var showCancelButton: Bool = false
    
    static var actionTitle: String = "取消"
    
    static var showSeparator: Bool = true
    
    var cancelHandler: (() -> Void)?
    
    var defaultContentHeight: CGFloat {
        get {
            if self.showTitleLabel {
                return self.tableViewHeight + CGFloat.saiha_verticalSize(num: 60)
            } else {
                return self.tableViewHeight
            }
        }
    }
    
    static var defaultShowCount: Int = 8
    var tableViewHeight: CGFloat {
        get {
            var height: CGFloat = 0
            if self.dataSource.count <= Self.defaultShowCount {
                height = CGFloat(self.dataSource.count) * CGFloat.saiha_verticalSize(num: 56)
            } else {
                height = CGFloat(Self.defaultShowCount) * CGFloat.saiha_verticalSize(num: 56)
            }
            return height
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setTableView()
        
        self.addSubview(self.titleLabel)
        
        self.cancelButton.addTarget(self, action: #selector(self.dismissWithCallBack), for: .touchUpInside)
        self.addSubview(self.cancelButton)        
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setTableView() {
        self.mainTableView = UITableView()
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        self.mainTableView.rowHeight = CGFloat.saiha_verticalSize(num: 56)
        self.mainTableView.separatorStyle = .none
        self.addSubview(self.mainTableView)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        if self.mainTableView != nil {
            self.mainTableView.snp.makeConstraints { make in
                make.left.right.bottom.equalToSuperview()
                make.height.equalTo(self.tableViewHeight)
            }
        }
        
        if self.showTitleLabel {
            self.titleLabel.isHidden = false
            self.titleLabel.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(CGFloat.saiha_horizontalSize(num: 20))
                make.bottom.equalTo(self.mainTableView.snp.top).offset(CGFloat.saiha_verticalSize(num: -20))
                make.width.greaterThanOrEqualTo(CGFloat.saiha_horizontalSize(num: 64))
                make.height.equalTo(CGFloat.saiha_verticalSize(num: 20))
            }
        } else {
            self.titleLabel.isHidden = true
        }
        
        if Self.showCancelButton && self.showTitleLabel {
            self.cancelButton.isHidden = false
            self.cancelButton.snp.makeConstraints { make in
                make.right.equalToSuperview().offset(CGFloat.saiha_verticalSize(num: -20))
                make.centerY.equalTo(self.titleLabel)
                make.width.height.equalTo(CGFloat.saiha_verticalSize(num: 20))
            }
        } else {
            self.cancelButton.isHidden = true
        }
    }
    
    func universalCellConfig(cell: SHContentSheetTableViewCell, index: Int) {
        let imageURL: String? = self.dataSource[index].iconURL
        if imageURL == nil {
            cell.showIcon = false
        } else {
            cell.showIcon = true
            cell.iconImageView?.saiha_loadImage(with: imageURL!)
        }
        cell.titleLabel.text = self.dataSource[index].title
        if index < self.dataSource.count - 1 {
            cell.showSeparator = Self.showSeparator
        } else {
            cell.showSeparator = false
        }
    }
    func setDefaultCell(cell: SHContentSheetTableViewCell, index: Int) {
        self.universalCellConfig(cell: cell, index: index)
    }
    func setMultipleSelectionCell(cell: SHContentSheetMultipleSelectionTableViewCell, index: Int) {
        self.universalCellConfig(cell: cell, index: index)
    }
    func setContentSwitchCell(cell: SHContentSheetSwitchTableViewCell, index: Int) {
        self.universalCellConfig(cell: cell, index: index)
    }
    
    func setDidSelectRowInDefaultStyle(index: Int) {}
    func setDidSelectRowInMultipleSelectionStyle(index: Int) {}
    func setDidSelectRowInContentSwitchSelectionStyle(index: Int) {}
    
    @objc func dismissWithCallBack() {
        SHContentSheetView.dismiss()
        self.cancelHandler?()
    }
    
    /// 自定义底部按钮标题。
    public static func setActionTitle(_ text: String) {
        SHContentSheetView.setActionTitle(text)
    }
    
    /**
     设置 `tableView` 默认显示的行个数。
    - Parameters:
        - count: 当数据源个数小于 `count` 时，`tableView` 会自适应高度并显示所有行。当数据源个数大于 `count` 时，`tableView` 将默认显示 `count` 个数，其余的滑动显示。
     */
    public static func setDefaultShowCount(count: Int) {
        Self.defaultShowCount = count
    }
    
    /// 是否显示每行的底部分割线。最后一行始终不显示底部分割线。
    public static func showSeparator(show: Bool) {
        Self.showSeparator = show
    }
    
    /// 是否显示标题行旁边的 `x` 按钮。如果因为 `title` 属性为 `nil` 导致标题行隐藏，则设置此属性无任何效果。默认不显示。
    public static func showCancelButton(show: Bool) {
        Self.showCancelButton = show
    }
    
    /// 自定义动画时间。
    public static func setAnimationDuration(duration: CGFloat) {
        SHContentSheetView.setAnimationDuration(duration: duration)
    }
}

extension SHContentSheetTableView: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch self.style! {
        case .default:
            let cell: SHContentSheetTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SHContentSheetTableViewCell", for: indexPath) as! SHContentSheetTableViewCell
            self.setDefaultCell(cell: cell, index: indexPath.row)
            return cell
        case .multipleSelection:
            let cell: SHContentSheetMultipleSelectionTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SHContentSheetMultipleSelectionTableViewCell", for: indexPath) as! SHContentSheetMultipleSelectionTableViewCell
            self.setMultipleSelectionCell(cell: cell, index: indexPath.row)
            return cell
        case .contentSwitch:
            let cell: SHContentSheetSwitchTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SHContentSheetSwitchTableViewCell", for: indexPath) as! SHContentSheetSwitchTableViewCell
            self.setContentSwitchCell(cell: cell, index: indexPath.row)
            return cell
        }
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch style! {
        case .default:
            self.setDidSelectRowInDefaultStyle(index: indexPath.row)
        case .multipleSelection:
            self.setDidSelectRowInMultipleSelectionStyle(index: indexPath.row)
        case .contentSwitch:
            self.setDidSelectRowInContentSwitchSelectionStyle(index: indexPath.row)
        }
    }
    
}
