//
//  SHContentSheetSwitchTableView.swift
//  Saiha
//
//  Created by 河瀬雫 on 2022/1/11.
//

import Foundation

@objc public protocol SHContentSheetSwitchTableViewDelegate {
    
    @objc optional func contentSheetSwitchTableView(_ contentSheetSwitchTableView: SHContentSheetSwitchTableView, didSwitchButtonStatusIn index: Int, with isOn: Bool)
    
    @objc optional func contentSheetSwitchTableView(_ contentSheetSwitchTableView: SHContentSheetSwitchTableView, canSwitchButtonIn index: Int) -> Bool
    
}

open class SHContentSheetSwitchTableView: SHContentSheetTableView {
    
    private static var sharedView: SHContentSheetSwitchTableView = SHContentSheetSwitchTableView()
    
    open weak var delegate: SHContentSheetSwitchTableViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.style = .contentSwitch
        Self.setActionTitle("保存")
        Self.showCancelButton = true
        self.showTitleLabel = true
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func setTableView() {
        super.setTableView()
        
        self.mainTableView.register(SHContentSheetSwitchTableViewCell.self, forCellReuseIdentifier: "SHContentSheetSwitchTableViewCell")
        self.mainTableView.allowsSelection = false
        self.mainTableView.allowsMultipleSelection = false
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func setContentSwitchCell(cell: SHContentSheetSwitchTableViewCell, index: Int) {
        super.setContentSwitchCell(cell: cell, index: index)
        
        cell.switchButton.isOn = self.dataSource[index].isOn
        cell.handleSwitch = { [weak self] switchButton in
            guard let strongSelf = self else { return }
            strongSelf.dataSource[index].isOn = switchButton.isOn
            strongSelf.delegate?.contentSheetSwitchTableView?(strongSelf, didSwitchButtonStatusIn: index, with: switchButton.isOn)
        }
        if let allowTouch = self.delegate?.contentSheetSwitchTableView?(self, canSwitchButtonIn: index) {
            cell.switchAllowTouch = allowTouch
        }
    }
    
    /**
     开关样式弹框。你可以实现 `SHContentSheetSwitchTableViewDelegate` 来实现每个开关的操作，或者更多自定义操作。
     
     - Parameters:
        - dataSource: `tableView` 的数据源。`tuple.0` 为 cell 的标题；`tuple.1` 为 cell 图标的 `url` 地址，若 `url` 为 `nil`，则图标不显示；`tuple.2` 为某个开关是否打开。
        - completionHandler: 在此样式下，该回调返回 `tableView` 的数据源，数据源保持原来的元组格式并记录了每个开关的状态。
        - cancelHandler: 若标题设置为 `nil`，即不显示标题行，那么设置此属性无任何效果。若标题行显示，并且显示了 `x` 按钮，则点击 `x` 按钮将执行此回调。
     */
    public static func show(title: String?, dataSource: [(title: String, url: String?, isOn: Bool)], delegate: SHContentSheetSwitchTableViewDelegate?, completionHandler: ((_ dataSource: [(title: String, url: String?, isOn: Bool)]) -> Void)?, cancelHandler: (() -> Void)?) {
        if Self.sharedView.superview != nil {
            return
        }
        
        Self.sharedView.title = title
        Self.sharedView.cancelHandler = cancelHandler
        Self.sharedView.delegate = delegate
        
        Self.sharedView.dataSource.removeAll()
        for item in dataSource {
            Self.sharedView.dataSource.append(SHContentSheetTableView.DataModel(title: item.title, iconURL: item.url, isOn: item.isOn))
        }
        Self.sharedView.mainTableView.reloadData()
        
        SHContentSheetView.show(customView: Self.sharedView, contentHeight: Self.sharedView.defaultContentHeight) {
            var dataSource: [(title: String, url: String?, isOn: Bool)] = []
            for item in Self.sharedView.dataSource {
                dataSource.append((title: item.title, url: item.iconURL, isOn: item.isOn))
            }
            completionHandler?(dataSource)
        }
    }
}
