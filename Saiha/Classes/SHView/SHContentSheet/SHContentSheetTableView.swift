//
//  SHContentSheetTableView.swift
//  Saiha
//
//  Created by 河瀬雫 on 2021/12/23.
//

import UIKit
import SnapKit

open class SHContentSheetTableViewCell: UITableViewCell {
    
    public enum WidgeAlignment: Int {
        case left
        case center
    }
    
    open var iconImageView: UIImageView?
    open var titleLabel: SHUILabel!
    open var markButton: UIButton = {
        let button: UIButton = UIButton()
        if #available(iOS 13.0, *) {
            button.setImage(UIImage(systemName: "checkmark"), for: .normal)
            button.tintColor = UIColor.defaultLabelColor
        } else {
            button.setImage(UIImage(named: "checkmark"), for: .normal)
        }
        button.imageView?.contentMode = .scaleAspectFit
        button.isUserInteractionEnabled = false
        return button
    }()
    
    open var showIcon: Bool = true
    
    private var hasAddSeparator: Bool = false
    open var showSeparator: Bool = true
    
    open var showMark: Bool = false
    
    open var widgeAlignment: SHContentSheetTableViewCell.WidgeAlignment = .left
    
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        if self.showIcon {
            self.iconImageView = UIImageView()
            self.iconImageView!.contentMode = .scaleAspectFit
            self.contentView.addSubview(self.iconImageView!)
            
            self.titleLabel = SHUILabel()
            self.titleLabel.text = "中通快递"
            self.titleLabel.font = .systemFont(ofSize: CGFloat.saiha_verticalSize(num: 16))
            self.contentView.addSubview(self.titleLabel)
        } else {
            self.titleLabel = SHUILabel()
            self.titleLabel.text = "中通快递"
            self.titleLabel.font = .systemFont(ofSize: CGFloat.saiha_verticalSize(num: 16))
            self.contentView.addSubview(self.titleLabel)
        }
        
        self.contentView.addSubview(self.markButton)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    open override func layoutSubviews() {
        if self.showIcon {
            if self.iconImageView != nil {
                let edge: CGFloat = self.widgeAlignment == .left ? CGFloat.saiha_horizontalSize(num: 20) : CGFloat.saiha_horizontalSize(num: 140)
                self.iconImageView!.snp.makeConstraints { make in
                    make.left.equalToSuperview().offset(edge)
                    make.centerY.equalToSuperview()
                    make.width.height.equalTo(CGFloat.saiha_verticalSize(num: 24))
                }
            }
            if self.titleLabel != nil {
                self.titleLabel.textAlignment = .left
                self.titleLabel.snp.makeConstraints { make in
                    make.left.equalTo(self.iconImageView!.snp.right).offset(CGFloat.saiha_horizontalSize(num: 8))
                    make.centerY.equalToSuperview()
                    make.width.greaterThanOrEqualTo(CGFloat.saiha_horizontalSize(num: 64))
                    make.height.greaterThanOrEqualTo(CGFloat.saiha_verticalSize(num: 16))
                }
            }
        } else {
            if self.titleLabel != nil {
                if self.widgeAlignment == .left {
                    let edge: CGFloat = self.widgeAlignment == .left ? CGFloat.saiha_horizontalSize(num: 20) : CGFloat.saiha_horizontalSize(num: 140)
                    self.titleLabel.snp.makeConstraints { make in
                        make.left.equalToSuperview().offset(edge)
                        make.centerY.equalToSuperview()
                        make.width.greaterThanOrEqualTo(CGFloat.saiha_horizontalSize(num: 64))
                        make.height.greaterThanOrEqualTo(CGFloat.saiha_verticalSize(num: 16))
                    }
                } else {
                    self.titleLabel.snp.makeConstraints { make in
                        make.centerX.equalToSuperview()
                        make.centerY.equalToSuperview()
                        make.width.greaterThanOrEqualTo(CGFloat.saiha_horizontalSize(num: 64))
                        make.height.greaterThanOrEqualTo(CGFloat.saiha_verticalSize(num: 16))
                    }
                }
            }
        }
        
        if self.showSeparator && self.hasAddSeparator == false {
            self.contentView.saiha_addSeparator(color: UIColor.saiha_colorWithHexString("#D8D8D8", alpha: 0.5), position: .bottom, leftEdge: CGFloat.saiha_horizontalSize(num: 16), rightEdge: CGFloat.saiha_horizontalSize(num: 18))
            self.hasAddSeparator = true
        }
        
        if self.showMark {
            self.markButton.isHidden = false
            self.markButton.snp.makeConstraints { make in
                make.right.equalToSuperview().offset(CGFloat.saiha_verticalSize(num: -20))
                make.centerY.equalTo(self.titleLabel)
                make.width.height.equalTo(CGFloat.saiha_verticalSize(num: 20))
            }
        } else {
            self.markButton.isHidden = true
        }
    }
}

open class SHContentSheetTableView: SHUIView {
    
    public enum SelectionStyle {
        
        /**
         默认单选，点击某个 cell 后视图自动消失，并回传选择的行序号。
         */
        case `default`(completionHandler: ((_ index: Int) -> Void), cancelHandler: (() -> Void)?)
        
        /**
         多选样式。可以选择多个 cell，点击底部按钮后回传选择的行序号数组。数组序号从小到大排序。选中此样式时，底部按钮标题将自动设置为“保存”。
         */
        case multipleSelection(completionHandler: ((_ indexSet: [Int]) -> Void), cancelHandler: (() -> Void)?)
    }
    
    private static var sharedView: SHContentSheetTableView = SHContentSheetTableView()

    private var titleLabel: SHUILabel = {
        let label: SHUILabel = SHUILabel()
        label.font = .systemFont(ofSize: CGFloat.saiha_verticalSize(num: 16), weight: .medium)
        return label
    }()
    private var cancelButton: SHUIButton = {
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
    private var mainTableView: UITableView!
    
    open var selectionStyle: SHContentSheetTableView.SelectionStyle = .default(completionHandler: { _ in }, cancelHandler: nil) {
        willSet {
            switch newValue {
            case .default(completionHandler: _, cancelHandler: _):
                Self.setActionTitle("取消")
                self.mainTableView.allowsSelection = true
                self.mainTableView.allowsMultipleSelection = false
            case .multipleSelection(completionHandler: _, cancelHandler: _):
                Self.setActionTitle("保存")
                self.mainTableView.allowsSelection = true
                self.mainTableView.allowsMultipleSelection = true
            }
        }
    }
    
    private var dataSource: [(title: String, url: String?)] = []
    private var multipleSelectedIndexSet: Set<Int> = []
    private var multipleSelectedIndex: [Int?] = []
    private var multipleSelectedCancelCallBack: (() -> Void)?
    
    private var showTitleLabel: Bool = true
    private var title: String? {
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
    
    private var showCancelButton: Bool = false
    
    private var actionTitle: String = "取消"
    
    private var showSeparator: Bool = true
    
    private var defaultContentHeight: CGFloat {
        get {
            if self.showTitleLabel {
                return self.tableViewHeight + CGFloat.saiha_verticalSize(num: 60)
            } else {
                return self.tableViewHeight
            }
        }
    }
    
    private var defaultShowCount: Int = 8
    private var tableViewHeight: CGFloat {
        get {
            var height: CGFloat = 0
            if self.dataSource.count <= self.defaultShowCount {
                height = CGFloat(self.dataSource.count) * CGFloat.saiha_verticalSize(num: 56)
            } else {
                height = CGFloat(self.defaultShowCount) * CGFloat.saiha_verticalSize(num: 56)
            }
            return height
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.mainTableView = UITableView()
        self.mainTableView.register(SHContentSheetTableViewCell.self, forCellReuseIdentifier: "SHContentSheetTableViewCell")
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        self.mainTableView.rowHeight = CGFloat.saiha_verticalSize(num: 56)
        self.mainTableView.separatorStyle = .none
        self.addSubview(self.mainTableView)
        
        self.addSubview(self.titleLabel)
        
        self.cancelButton.addTarget(self, action: #selector(self.dismissWithCallBack), for: .touchUpInside)
        self.addSubview(self.cancelButton)        
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
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
        
        switch self.selectionStyle {
        case .multipleSelection(completionHandler: _, cancelHandler: _):
            if self.showCancelButton && self.showTitleLabel {
                self.cancelButton.isHidden = false
                self.cancelButton.snp.makeConstraints { make in
                    make.right.equalToSuperview().offset(CGFloat.saiha_verticalSize(num: -20))
                    make.centerY.equalTo(self.titleLabel)
                    make.width.height.equalTo(CGFloat.saiha_verticalSize(num: 20))
                }
            } else {
                self.cancelButton.isHidden = true
            }
        case .default(completionHandler: _, cancelHandler: _):
            self.cancelButton.isHidden = true
        }
    }
    
    /**
     从底部弹出 `tableView`。
    
     - Parameters:
        - title: 视图的标题。若为 `nil`，则不显示 titleLabel。若有值，则在 tableView 上方添加一个 titleLabel。
        - dataSource: tableView 的数据源。`tuple.0` 为 cell 的标题；`tuple.1` 为 cell 图标的 url 地址。若 url 为 `nil`，则图标不显示。
        - style: 设置弹出视图的选择模式。
     */
    public static func show(title: String?, dataSource: [(title: String, url: String?)], style: SHContentSheetTableView.SelectionStyle) {
        if Self.sharedView.superview != nil {
            return
        }
        Self.sharedView.selectionStyle = style
        Self.sharedView.dataSource = dataSource
        Self.sharedView.title = title
        switch style {
        case let .default(completionHandler: _, cancelHandler: cancelHandler):
            break
        case let .multipleSelection(completionHandler: completionHandler, cancelHandler: cancelHandler):
            Self.sharedView.multipleSelectedCancelCallBack = cancelHandler
            Self.sharedView.multipleSelectedIndex = [Int?](repeating: nil, count: dataSource.count)
        }
        
        SHContentSheetView.show(customView: Self.sharedView, contentHeight: Self.sharedView.defaultContentHeight) {
            switch style {
            case let .default(completionHandler: _, cancelHandler: cancelHandler):
                cancelHandler?()
            case let .multipleSelection(completionHandler: completionHandler, cancelHandler: cancelHandler):
                let indexs: [Int] = Self.sharedView.multipleSelectedIndexSet.sorted()
                completionHandler(indexs)
            }
        }
    }
    
    @objc private func dismissWithCallBack() {
        SHContentSheetView.dismiss()
        self.multipleSelectedCancelCallBack?()
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
}

extension SHContentSheetTableView: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
        case let .default(completionHandler: completionHandler, cancelHandler: _):
            cell.showMark = false
            cell.widgeAlignment = .center
        case let .multipleSelection(completionHandler: completionHandler, cancelHandler: _):
            if self.multipleSelectedIndex[indexPath.row] != nil {
                cell.showMark = true
            } else {
                cell.showMark = false
            }
            cell.widgeAlignment = .left
        }
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch self.selectionStyle {
        case let .default(completionHandler: completionHandler, cancelHandler: _):
            completionHandler(indexPath.row)
            SHContentSheetView.dismiss()
        case let .multipleSelection(completionHandler: completionHandler, cancelHandler: _):
            self.multipleSelectedIndexSet.update(with: indexPath.row)
            if self.multipleSelectedIndex[indexPath.row] == nil {
                self.multipleSelectedIndex[indexPath.row] = indexPath.row
            } else {
                self.multipleSelectedIndex[indexPath.row] = nil
            }
            self.mainTableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
}
