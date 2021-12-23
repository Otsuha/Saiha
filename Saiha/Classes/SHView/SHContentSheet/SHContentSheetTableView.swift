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
        
        self.contentView.saiha_addSeparator(color: UIColor.saiha_colorWithHexString("#D8D8D8", alpha: 0.5), position: .bottom, leftEdge: CGFloat.saiha_horizontalSize(num: 16), rightEdge: CGFloat.saiha_horizontalSize(num: 18))
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
    }
}

open class SHContentSheetTableView: UIView, UITableViewDataSource, UITableViewDelegate {
    
    public enum SelectionStyle {
        case `default`(completionHandler: ((_ index: Int) -> Void), cancelHandler: (() -> Void)?)
        case multipleSelection(completionHandler: ((_ indexSet: [Int]) -> Void), cancelHandler: (() -> Void)?)
    }

    private var titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .systemFont(ofSize: CGFloat.saiha_verticalSize(num: 16), weight: .medium)
        return label
    }()
    private var mainTableView: UITableView!
    
    open var selectionStyle: SHContentSheetTableView.SelectionStyle!
    
    open var dataSource: [(title: String, url: String?)] = []
    
    open var showTitleLabel: Bool = true
    open var title: String? {
        didSet {
            self.titleLabel.text = self.title
        }
    }
    
    open var defaultContentHeight: CGFloat {
        get {
            if self.showTitleLabel {
                return self.tableViewHeight + CGFloat.saiha_verticalSize(num: 60)
            } else {
                return self.tableViewHeight
            }
        }
    }
    
    private var tableViewHeight: CGFloat {
        get {
            var height: CGFloat = 0
            if self.dataSource.count <= 8 {
                height = CGFloat(self.dataSource.count) * CGFloat.saiha_verticalSize(num: 56)
            } else {
                height = 8 * CGFloat.saiha_verticalSize(num: 56)
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
    
    private func dismissView() {
        self.isHidden = true
        self.removeFromSuperview()
    }
    
    public static func show(title: String?, dataSource: [(title: String, url: String?)], style: SHContentSheetTableView.SelectionStyle) {
        let contentSheetTableView: SHContentSheetTableView = SHContentSheetTableView()
        contentSheetTableView.selectionStyle = style
        contentSheetTableView.dataSource = dataSource
        if title != nil {
            contentSheetTableView.showTitleLabel = true
            contentSheetTableView.title = title
        } else {
            contentSheetTableView.showTitleLabel = false
        }
        
        SHContentSheetView.show(customView: contentSheetTableView, contentHeight: contentSheetTableView.defaultContentHeight) {
            SHContentSheetView.dismiss()
        }
    }
    
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
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch self.selectionStyle {
        case let .default(completionHandler: completionHandler, cancelHandler: _):
            completionHandler(indexPath.row)
            SHContentSheetView.dismiss()
        case let .multipleSelection(completionHandler: completionHandler, cancelHandler: _):
            completionHandler([indexPath.row])
        case .none:
            break
        }
    }
}
