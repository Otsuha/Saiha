//
//  SHContentSheetDefaultTableView.swift
//  Saiha
//
//  Created by 河瀬雫 on 2022/1/11.
//

import Foundation

open class SHContentSheetDefaultTableView: SHContentSheetTableView {
    
    private static var sharedView: SHContentSheetDefaultTableView = SHContentSheetDefaultTableView()
    
    private var completionHandler: ((_ index: Int) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.style = .default
        
        self.cancelButton.isHidden = true
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func setTableView() {
        super.setTableView()
        
        self.mainTableView.register(SHContentSheetTableViewCell.self, forCellReuseIdentifier: "SHContentSheetTableViewCell")
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func setDefaultCell(cell: SHContentSheetTableViewCell, index: Int) {
        super.setDefaultCell(cell: cell, index: index)
        
        cell.widgeAlignment = .center
    }
    
    override func setDidSelectRowInDefaultStyle(index: Int) {
        super.setDidSelectRowInDefaultStyle(index: index)
        
        self.completionHandler?(index)
        SHContentSheetView.dismiss()
    }
    
    /**
     默认单选样式弹框，点击某个 cell 后视图自动消失，并回传选择的行序号。
     
     - Parameters:
        - dataSource: `tableView` 的数据源。`tuple.0` 为 cell 的标题；`tuple.1` 为 cell 图标的 `url` 地址。若 `url` 为 `nil`，则图标不显示。
        - selectedIndex: 是否默认选中某行，传 `nil` 不进行默认选中操作，若传具体值，则对应行右边显示打钩标记。
        - completionHandler: 点击底部按钮的回调，回传选择的行序号。
        - cancelHandler: 若标题设置为 `nil`，即不显示标题行，那么设置此属性无任何效果。若标题行显示，并且显示了 `x` 按钮，则点击 `x` 按钮将执行此回调。
     */
    public static func show(title: String?, dataSource: [(title: String, url: String?)], selectedIndex: Int?, completionHandler: @escaping ((_ index: Int) -> Void), cancelHandler: (() -> Void)?) {
        if Self.sharedView.superview != nil {
            return
        }
        
        Self.sharedView.setTableView()
        Self.sharedView.title = title
        Self.sharedView.completionHandler = completionHandler
        Self.sharedView.cancelHandler = cancelHandler
        
        Self.sharedView.dataSource.removeAll()
        for (index, item) in dataSource.enumerated() {
            var isSelected: Bool = false
            if selectedIndex != nil && index == selectedIndex! {
                isSelected = true
            }
            Self.sharedView.dataSource.append(SHContentSheetTableView.DataModel(title: item.title, iconURL: item.url, isSelected: isSelected))
        }
        
        SHContentSheetView.show(customView: Self.sharedView, contentHeight: Self.sharedView.defaultContentHeight) {
            cancelHandler?()
        }
    }
}
