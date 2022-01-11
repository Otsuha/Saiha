//
//  SHContentSheetMultipleSelectionTableView.swift
//  Saiha
//
//  Created by 河瀬雫 on 2022/1/10.
//

import Foundation

open class SHContentSheetMultipleSelectionTableView: SHContentSheetTableView {
    
    private static var sharedView: SHContentSheetMultipleSelectionTableView = SHContentSheetMultipleSelectionTableView()
    
    private var multipleSelectedIndexSet: Set<Int> = []
    private var multipleSelectedIndex: [Int?] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.style = .multipleSelection
        Self.setActionTitle("保存")
        Self.showCancelButton = true
        self.showTitleLabel = true
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func setTableView() {
        super.setTableView()
        
        self.mainTableView.register(SHContentSheetMultipleSelectionTableViewCell.self, forCellReuseIdentifier: "SHContentSheetMultipleSelectionTableViewCell")
        self.mainTableView.allowsSelection = true
        self.mainTableView.allowsMultipleSelection = true
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func setMultipleSelectionCell(cell: SHContentSheetMultipleSelectionTableViewCell, index: Int) {
        super.setMultipleSelectionCell(cell: cell, index: index)
        
        cell.showMark = self.dataSource[index].isSelected
        cell.widgeAlignment = .left
    }
    
    override func setDidSelectRowInMultipleSelectionStyle(index: Int) {
        super.setDidSelectRowInMultipleSelectionStyle(index: index)
        
        if self.multipleSelectedIndex[index] == nil {
            self.multipleSelectedIndex[index] = index
            self.dataSource[index].isSelected = true
            self.multipleSelectedIndexSet.update(with: index)
        } else {
            self.multipleSelectedIndex[index] = nil
            self.dataSource[index].isSelected = false
            self.multipleSelectedIndexSet.remove(index)
        }
        self.mainTableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
    
    /**
     多选样式弹框。可以选择多个 cell，点击底部按钮后回传选择的行序号数组。数组序号从小到大排序。选中此样式时，底部按钮标题将自动设置为“保存”。
     
     - Parameters:
        - dataSource: `tableView` 的数据源。`tuple.0` 为 cell 的标题；`tuple.1` 为 cell 图标的 `url` 地址，若 `url` 为 `nil`，则图标不显示；`tuple.2` 为某个开关是否打开。
        - completionHandler: 点击底部按钮的回调，回传选择的行序号。
        - cancelHandler: 若标题设置为 `nil`，即不显示标题行，那么设置此属性无任何效果。若标题行显示，并且显示了 `x` 按钮，则点击 `x` 按钮将执行此回调。
     */
    public static func show(title: String?, dataSource: [(title: String, url: String?, isSelected: Bool)], completionHandler: @escaping ((_ indexSet: [Int]) -> Void), cancelHandler: (() -> Void)?) {
        if Self.sharedView.superview != nil {
            return
        }
        
        Self.sharedView.title = title
        Self.sharedView.cancelHandler = cancelHandler
        
        Self.sharedView.multipleSelectedIndex = [Int?](repeating: nil, count: dataSource.count)
        Self.sharedView.multipleSelectedIndexSet.removeAll()
        Self.sharedView.dataSource.removeAll()
        for (index, item) in dataSource.enumerated() {
            if item.isSelected {
                Self.sharedView.multipleSelectedIndex[index] = index
                Self.sharedView.multipleSelectedIndexSet.update(with: index)
            }
            Self.sharedView.dataSource.append(SHContentSheetTableView.DataModel(title: item.title, iconURL: item.url, isSelected: item.isSelected))
        }
        Self.sharedView.mainTableView.reloadData()
        
        SHContentSheetView.show(customView: Self.sharedView, contentHeight: Self.sharedView.defaultContentHeight) {
            let indexs: [Int] = Self.sharedView.multipleSelectedIndexSet.sorted()
            completionHandler(indexs)
        }
    }
}
