//
//  SHContentSheetTableView.swift
//  Saiha
//
//  Created by 河瀬雫 on 2021/12/23.
//

import UIKit
import SnapKit

@objc public protocol SHContentSwitchSheetViewDelegate {
    
    @objc optional func contentSwitchSheetView(_ contentSwitchSheetView: SHContentSheetTableView, didSwitchButtonStatusIn index: Int, with isOn: Bool)
    
    @objc optional func contentSwitchSheetView(_ contentSwitchSheetView: SHContentSheetTableView, canSwitchButtonIn index: Int) -> Bool
}

open class SHContentSheetTableView: SHUIView {
    
    enum Style {
        case `default`
        case multipleSelection(dataSource: [(title: String, url: String?, isSelected: Bool)])
        case contentSwitch
    }
    
    public enum SelectionStyle {
        
        /**
         默认单选，点击某个 cell 后视图自动消失，并回传选择的行序号。
         
         - Parameters:
            - dataSource: `tableView` 的数据源。`tuple.0` 为 cell 的标题；`tuple.1` 为 cell 图标的 `url` 地址。若 `url` 为 `nil`，则图标不显示。
            - selectedIndex: 是否默认选中某行，传 `nil` 不进行默认选中操作，若传具体值，则对应行右边显示打钩标记。
            - completionHandler: 点击底部按钮的回调，回传选择的行序号。
            - cancelHandler: 若标题设置为 `nil`，即不显示标题行，那么设置此属性无任何效果。若标题行显示，并且显示了 `x` 按钮，则点击 `x` 按钮将执行此回调。
         */
        case `default`(dataSource: [(title: String, url: String?)], selectedIndex: Int?, completionHandler: ((_ index: Int) -> Void), cancelHandler: (() -> Void)?)
        
        /**
         开关选择样式，可以控制多个开关选项。此时底部按钮标题将默认被设置为“保存”。可以实现 `SHContentSwitchSheetViewDelegate` 协议以进行更多的自定义操作。
         
         - Parameters:
            - dataSource: `tableView` 的数据源。`tuple.0` 为 cell 的标题；`tuple.1` 为 cell 图标的 `url` 地址，若 `url` 为 `nil`，则图标不显示；`tuple.2` 为是否选中某个 cell。
            - completionHandler: 点击底部按钮的回调，回传选择的行序号。
            - cancelHandler: 若标题设置为 `nil`，即不显示标题行，那么设置此属性无任何效果。若标题行显示，并且显示了 `x` 按钮，则点击 `x` 按钮将执行此回调。
         */
        case contentSwitch(dataSource: [(icon: UIImage?, title: String, isOn: Bool)], delegate: SHContentSwitchSheetViewDelegate, completionHandler: (() -> Void)?, cancelHandler: (() -> Void)?)
    }
    
    private static var sharedView: SHContentSheetTableView = SHContentSheetTableView()

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
            button.setImage(UIImage(named: "xmark"), for: .normal)
        }
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    var mainTableView: UITableView!
    
    open var selectionStyle: SHContentSheetTableView.SelectionStyle = .default(dataSource: [], selectedIndex: nil, completionHandler: { _ in }, cancelHandler: nil) {
        willSet {
            switch newValue {
            case .default(dataSource: _, selectedIndex: _, completionHandler: _, cancelHandler: _):
                Self.setActionTitle("取消")
                self.mainTableView.allowsSelection = true
                self.mainTableView.allowsMultipleSelection = false
            case .contentSwitch(dataSource: _, delegate: _, completionHandler: _, cancelHandler: _):
                break
            }
        }
    }
    
    var style: SHContentSheetTableView.Style!
    
    var dataSourceCount: Int = 0
        
    var showTitleLabel: Bool = true
    var title: String? {
        willSet {
            self.titleLabel.text = newValue
            if newValue == nil {
                self.showTitleLabel = false
                self.showCancelButton = false
            } else {
                self.showTitleLabel = true
                self.showCancelButton = true
            }
        }
    }
    
    var showCancelButton: Bool = false
    
    var actionTitle: String = "取消"
    
    var showSeparator: Bool = true
    
    var defaultContentHeight: CGFloat {
        get {
            if self.showTitleLabel {
                return self.tableViewHeight + CGFloat.saiha_verticalSize(num: 60)
            } else {
                return self.tableViewHeight
            }
        }
    }
    
    var defaultShowCount: Int = 8
    var tableViewHeight: CGFloat {
        get {
            var height: CGFloat = 0
            if self.dataSourceCount <= self.defaultShowCount {
                height = CGFloat(self.dataSourceCount) * CGFloat.saiha_verticalSize(num: 56)
            } else {
                height = CGFloat(self.defaultShowCount) * CGFloat.saiha_verticalSize(num: 56)
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
    
    func setDefaultStyle(dataSource: [(title: String, url: String?)], selectedIndex: Int?) {}
    func setMultipleSelectionStyle(dataSource: [(title: String, url: String?, isSelected: Bool)]) {}
    func setContentSwitchStyle(dataSource: [(icon: UIImage?, title: String, isOn: Bool)], delegate: SHContentSwitchSheetViewDelegate) {}
    
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
        
        switch self.selectionStyle {
        case .default(dataSource: _, selectedIndex: _, completionHandler: _, cancelHandler: _):
            self.cancelButton.isHidden = true
            
        case .contentSwitch(dataSource: _, delegate: _, completionHandler: _, cancelHandler: _):
            break
        }
    }
    
    func universalCellConfig(cell: SHContentSheetTableViewCell, index: Int) {
        switch self.style! {
        case let .multipleSelection(dataSource: dataSource):
            let imageURL: String? = dataSource[index].url
            if imageURL == nil {
                cell.showIcon = false
            } else {
                cell.showIcon = true
                cell.iconImageView?.saiha_loadImage(with: imageURL!)
            }
            cell.titleLabel.text = dataSource[index].title
            if index < dataSource.count - 1 {
                cell.showSeparator = self.showSeparator
            } else {
                cell.showSeparator = false
            }
        default:
            break
        }
    }
    func setDefaultCell(cell: SHContentSheetTableViewCell, index: Int) {
        self.universalCellConfig(cell: cell, index: index)
    }
    func setMultipleSelectionCell(cell: SHContentSheetMultipleSelectionTableViewCell, index: Int) {
        self.universalCellConfig(cell: cell, index: index)
    }
    func setContentSwitchCell(cell: SHContentSheetTableViewCell, index: Int) {}
    
    /**
     从底部弹出 `tableView`。
    
     - Parameters:
        - title: 视图的标题。若为 `nil`，则不显示 titleLabel。若有值，则在 tableView 上方添加一个 titleLabel。
        - style: 设置弹出视图的选择模式。
     */
    public static func show(title: String?, style: SHContentSheetTableView.SelectionStyle) {
        if Self.sharedView.superview != nil {
            return
        }
        
        Self.sharedView.selectionStyle = style
        Self.sharedView.title = title
        
        switch style {
        case let .default(dataSource: dataSource, selectedIndex: selectedIndex, completionHandler: _, cancelHandler: _):
            Self.sharedView.setDefaultStyle(dataSource: dataSource, selectedIndex: selectedIndex)
            
        case let .contentSwitch(dataSource: dataSource, delegate: delegate, completionHandler: _, cancelHandler: _):
            self.sharedView.setContentSwitchStyle(dataSource: dataSource, delegate: delegate)
        }
        
        SHContentSheetView.show(customView: Self.sharedView, contentHeight: Self.sharedView.defaultContentHeight) {
            switch style {
            case let .default(dataSource: _, selectedIndex: _, completionHandler: _, cancelHandler: cancelHandler):
                cancelHandler?()
            case .contentSwitch(dataSource: _, delegate: _, completionHandler: _, cancelHandler: _):
                break
            }
        }
    }
    
    @objc func dismissWithCallBack() {
        SHContentSheetView.dismiss()
    }
    
    /// 自定义底部按钮标题。
    public static func setActionTitle(_ text: String) {
        SHContentSheetView.setActionTitle(text)
    }
    
    /**
     设置 tableView 默认显示的行个数。
    - Parameters:
        - count: 当数据源个数小于 `count` 时，tableView 会自适应高度并显示所有行。当数据源个数大于 `count` 时，tableView 将默认显示 count 个数，其余的滑动显示。
     */
    public static func setDefaultShowCount(count: Int) {
        Self.sharedView.defaultShowCount = count
    }
    
    /// 是否显示每行的底部分割线。最后一行始终不显示底部分割线。
    public static func showSeparator(show: Bool) {
        Self.sharedView.showSeparator = show
    }
    
    /// 是否显示标题行旁边的 “x” 按钮。如果因为 `title` 属性为 `nil` 导致标题行隐藏，则设置此属性无任何效果。默认不显示。
    public static func showCancelButton(show: Bool) {
        Self.sharedView.showCancelButton = show
    }
    
    /// 自定义动画时间。
    public static func setAnimationDuration(duration: CGFloat) {
        SHContentSheetView.setAnimationDuration(duration: duration)
    }
}

extension SHContentSheetTableView: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSourceCount
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch self.style! {
        case .default:
            break
        case .multipleSelection:
            var cell: SHContentSheetMultipleSelectionTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SHContentSheetMultipleSelectionTableViewCell", for: indexPath) as! SHContentSheetMultipleSelectionTableViewCell
            self.setMultipleSelectionCell(cell: cell, index: indexPath.row)
        case .contentSwitch:
            break
        }
        
        
        
        let cell: SHContentSheetTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SHContentSheetTableViewCell", for: indexPath) as! SHContentSheetTableViewCell
        let imageURL: String? = self.dataSource[indexPath.row].url
        if imageURL == nil {
            cell.showIcon = false
        } else {
            cell.showIcon = true
            cell.iconImageView?.saiha_loadImage(with: imageURL!)
        }
        cell.titleLabel.text = self.dataSource[indexPath.row].title
        if indexPath.row < self.dataSource.count - 1 {
            cell.showSeparator = self.showSeparator
        } else {
            cell.showSeparator = false
        }
        switch self.selectionStyle {
        case .default(dataSource: _, selectedIndex: _, completionHandler: _, cancelHandler: _):
            cell.showMark = false
            cell.widgeAlignment = .center
        case .multipleSelection(dataSource: _, completionHandler: _, cancelHandler: _):
            if self.multipleSelectedIndex[indexPath.row] != nil {
                cell.showMark = true
            } else {
                cell.showMark = false
            }
            cell.widgeAlignment = .left
        case .contentSwitch(dataSource: _, delegate: _, completionHandler: _, cancelHandler: _):
            break
        }
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch self.selectionStyle {
        case let .default(dataSource: _, selectedIndex: _, completionHandler: completionHandler, cancelHandler: _):
            completionHandler(indexPath.row)
            SHContentSheetView.dismiss()
        case .multipleSelection(dataSource: _, completionHandler: _, cancelHandler: _):
            self.multipleSelectedIndexSet.update(with: indexPath.row)
            if self.multipleSelectedIndex[indexPath.row] == nil {
                self.multipleSelectedIndex[indexPath.row] = indexPath.row
            } else {
                self.multipleSelectedIndex[indexPath.row] = nil
            }
            self.mainTableView.reloadRows(at: [indexPath], with: .automatic)
        case .contentSwitch(dataSource: _, delegate: _, completionHandler: _, cancelHandler: _):
            break
        }
    }
    
}
