//
//  SHContentSheetTableView.swift
//  Saiha
//
//  Created by 河瀬雫 on 2021/12/23.
//

import UIKit

open class SHContentSheetTableViewCell: UITableViewCell {
    
    open var iconImageView: UIImageView?
    open var titleLabel: UILabel!
    
    open var showIcon: Bool = true
    
    private var hasAddSeparator: Bool = false
    open var showSeparator: Bool = true
    
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        if self.showIcon {
            self.iconImageView = UIImageView()
            self.iconImageView!.contentMode = .scaleAspectFit
            self.contentView.addSubview(self.iconImageView!)
            
            self.titleLabel = UILabel()
            self.titleLabel.text = "中通快递"
            self.titleLabel.font = .systemFont(ofSize: CGFloat.saiha_verticalSize(num: 16))
            self.contentView.addSubview(self.titleLabel)
        } else {
            self.titleLabel = UILabel()
            self.titleLabel.text = "中通快递"
            self.titleLabel.font = .systemFont(ofSize: CGFloat.saiha_verticalSize(num: 16))
            self.contentView.addSubview(self.titleLabel)
        }
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func layoutSubviews() {
        if self.showIcon {
            if self.iconImageView != nil {
                self.iconImageView!.snp.makeConstraints { make in
                    make.left.equalToSuperview().offset(CGFloat.saiha_horizontalSize(num: 140))
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
                self.titleLabel.textAlignment = .center
                self.titleLabel.snp.makeConstraints { make in
                    make.centerX.equalToSuperview()
                    make.centerY.equalToSuperview()
                    make.width.greaterThanOrEqualTo(CGFloat.saiha_horizontalSize(num: 64))
                    make.height.greaterThanOrEqualTo(CGFloat.saiha_verticalSize(num: 16))
                }
            }
        }
        
        if self.showSeparator && self.hasAddSeparator == false {
            self.contentView.saiha_addSeparator(color: UIColor.saiha_colorWithHexString("#D8D8D8", alpha: 0.5), position: .bottom, leftEdge: CGFloat.saiha_horizontalSize(num: 16), rightEdge: CGFloat.saiha_horizontalSize(num: 18))
            self.hasAddSeparator = true
        }
    }
}

open class SHContentSheetTableView: UIView {
    
    public enum SelectionStyle {
        
        /**
         默认单选，点击某个 cell 后视图自动消失，并回传选择的行序号。
         */
        case `default`(completionHandler: ((_ index: Int) -> Void), cancelHandler: (() -> Void)?)
        
        /**
         多选样式。可以选择多个 cell，点击底部按钮后回传选择的行序号数组。数组序号从小到大排序。
         */
        case multipleSelection(completionHandler: ((_ indexSet: [Int]) -> Void), cancelHandler: (() -> Void)?)
    }
    
    private static var sharedView: SHContentSheetTableView?

    private var titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .systemFont(ofSize: CGFloat.saiha_verticalSize(num: 16), weight: .medium)
        return label
    }()
    private var mainTableView: UITableView!
    
    open var selectionStyle: SHContentSheetTableView.SelectionStyle = .default(completionHandler: { _ in }, cancelHandler: nil)
    
    private var dataSource: [(title: String, url: String?)] = []
    
    private var showTitleLabel: Bool = true
    private var title: String? {
        willSet {
            self.titleLabel.text = newValue
            if newValue == nil {
                self.showTitleLabel = false
            } else {
                self.showTitleLabel = true
            }
        }
    }
    
    private static var actionTitle: String = "取消"
    
    private static var showSeparator: Bool = true
    
    private var defaultContentHeight: CGFloat {
        get {
            if self.showTitleLabel {
                return self.tableViewHeight + CGFloat.saiha_verticalSize(num: 60)
            } else {
                return self.tableViewHeight
            }
        }
    }
    
    private static var defaultShowCount: Int = 8
    private var tableViewHeight: CGFloat {
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
        
        self.mainTableView = UITableView()
        self.mainTableView.register(SHContentSheetTableViewCell.self, forCellReuseIdentifier: "SHContentSheetTableViewCell")
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        self.mainTableView.rowHeight = CGFloat.saiha_verticalSize(num: 56)
        self.addSubview(self.mainTableView)
        
        self.titleLabel.text = self.title
        self.addSubview(self.titleLabel)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    }
    
    /**
     从底部弹出 `tableView`。
    
     - Parameters:
        - title: 视图的标题。若为 `nil`，则不显示 titleLabel。若有值，则在 tableView 上方添加一个 titleLabel。
        - dataSource: tableView 的数据源。`tuple.0` 为 cell 的标题；`tuple.1` 为 cell 图标的 url 地址。若 url 为 `nil`，则图标不显示。
        - style: 设置弹出视图的选择模式。
     */
    public static func show(title: String?, dataSource: [(title: String, url: String?)], style: SHContentSheetTableView.SelectionStyle) {
        if Self.sharedView?.superview != nil {
            return
        }
        let contentSheetTableView: SHContentSheetTableView = SHContentSheetTableView()
        contentSheetTableView.selectionStyle = style
        contentSheetTableView.dataSource = dataSource
        contentSheetTableView.title = title
        Self.sharedView = contentSheetTableView
        
        SHContentSheetView.show(customView: contentSheetTableView, contentHeight: contentSheetTableView.defaultContentHeight) {
            switch style {
            case let .default(completionHandler: _, cancelHandler: cancelHandler):
                cancelHandler?()
            case let .multipleSelection(completionHandler: _, cancelHandler: cancelHandler):
                cancelHandler?()
            }
            //SHContentSheetView.dismiss()
        }
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
        Self.defaultShowCount = count
    }
    
    /// 是否显示每行的底部分割线。最后一行始终不显示底部分割线。
    public static func showSeparator(show: Bool) {
        Self.showSeparator = show
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
            cell.showSeparator = Self.showSeparator
        } else {
            cell.showSeparator = false
        }
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch self.selectionStyle {
        case let .default(completionHandler: completionHandler, cancelHandler: _):
            completionHandler(indexPath.row)
            SHContentSheetView.dismiss()
        case let .multipleSelection(completionHandler: completionHandler, cancelHandler: _):
            completionHandler([indexPath.row])
        }
    }
}
