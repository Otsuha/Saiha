//
//  SHContentSwitchSheetView.swift
//  Saiha
//
//  Created by 御前崎悠羽 on 2021/11/11.
//

import UIKit

open class SHContentSwitchSheetView: SHContentSheetView, UITableViewDataSource {

    private var titleLabel: SHUILabel!
    private var switchContentView: SHUIView!
    private var mainTableView: UITableView!
    
    open var statusTaleHandler: ((_ statusTable: inout [Bool]) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.titleLabel = SHUILabel()
        self.titleLabel.text = "照片上传"
        self.titleLabel.font = .systemFont(ofSize: CGFloat.saiha.verticalSize(num: 16), weight: .medium)
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(CGFloat.saiha.horizontalSize(num: 20))
            make.top.equalToSuperview().offset(CGFloat.saiha.verticalSize(num: 20))
            make.width.greaterThanOrEqualTo(CGFloat.saiha.horizontalSize(num: 64))
        }
        
        self.switchContentView = SHUIView()
        self.addSubview(self.switchContentView)
        self.switchContentView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(self.titleLabel.snp.bottom)
        }
        
        self.mainTableView = UITableView()
        self.mainTableView.register(SHContentSwitchSheetCell.self, forCellReuseIdentifier: "SHContentSwitchSheetCell")
        self.mainTableView.dataSource = self
        self.mainTableView.rowHeight = CGFloat.saiha.verticalSize(num: 56)
        self.mainTableView.separatorColor = UIColor.saiha.colorWithHexString("#D8D8D8", alpha: 0.5)
        self.mainTableView.separatorInset = UIEdgeInsets(top: 0, left: CGFloat.saiha.horizontalSize(num: 16), bottom: 0, right: CGFloat.saiha.horizontalSize(num: -18))
        self.switchContentView.addSubview(self.mainTableView)
        self.mainTableView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
        
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    public static func show(contentHeight: CGFloat, dataSource: [(icon: UIImage?, title: String, isOn: Bool)], _ completionHandler: @escaping (_ statusTable: inout [Bool]) -> Void) {
//        let sheetView: SHContentSwitchSheetView = SHContentSwitchSheetView()
//        sheetView.contentHeight = contentHeight
//        sheetView.statusTaleHandler = completionHandler
//        SHContentSheetView.show(customView: sheetView, contentHeight: contentHeight, completionHandler: { dataSource in
//
//        })
//
//    }
    
//    @objc override func touchCancelAction(sender: UIButton) {
//        if self.delegate?.contentSheetView?(didTapCancelActionIn: self) == nil {
//            self.isHidden = true
//            self.removeFromSuperview()
//            var tables: [Bool] = []
//            for status in (self.dataSource as! [String: Bool]) {
//                tables.append(status.isOn)
//            }
//            self.statusTaleHandler?(&tables)
//        }
//    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SHContentSwitchSheetCell = tableView.dequeueReusableCell(withIdentifier: "SHContentSwitchSheetCell", for: indexPath) as! SHContentSwitchSheetCell
//        cell.switchButton.isOn = self.dataSource[indexPath.row].isOn
//        cell.titleLabel.text = self.dataSource[indexPath.row].title
//        if let image = self.dataSource[indexPath.row].icon {
//            cell.showIcon = true
//            cell.iconImageView?.image = image
//        } else {
//            cell.showIcon = false
//        }
//        cell.handleSwitch = { [weak self] switchButton in
//            guard let strongSelf = self else { return }
//            strongSelf.dataSource[indexPath.row].isOn = switchButton.isOn
//        }
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
                make.left.equalToSuperview().offset(CGFloat.saiha.horizontalSize(num: 20))
                make.centerY.equalToSuperview()
                make.width.height.equalTo(CGFloat.saiha.verticalSize(num: 24))
            })
            
            self.titleLabel = SHUILabel()
            self.titleLabel.text = "中通快递"
            self.titleLabel.font = .systemFont(ofSize: CGFloat.saiha.verticalSize(num: 16))
            self.contentView.addSubview(self.titleLabel)
            self.titleLabel.snp.makeConstraints { make in
                make.left.equalTo(self.iconImageView!.snp.right).offset(CGFloat.saiha.horizontalSize(num: 8))
                make.centerY.equalToSuperview()
                make.width.greaterThanOrEqualTo(CGFloat.saiha.horizontalSize(num: 64))
            }
        } else {
            self.titleLabel = SHUILabel()
            self.titleLabel.text = "中通快递"
            self.titleLabel.font = .systemFont(ofSize: CGFloat.saiha.verticalSize(num: 16))
            self.contentView.addSubview(self.titleLabel)
            self.titleLabel.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(CGFloat.saiha.horizontalSize(num: 20))
                make.centerY.equalToSuperview()
                make.width.height.equalTo(CGFloat.saiha.verticalSize(num: 64))
            }
        }
        self.switchButton = UISwitch()
        self.switchButton.isOn = true
        self.switchButton.onTintColor = UIColor.saiha.colorWithHexString("#3951C4")
        self.switchButton.addTarget(self, action: #selector(self.handleSwitch(sender:)), for: .touchUpInside)
        self.contentView.addSubview(self.switchButton)
        self.switchButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(CGFloat.saiha.verticalSize(num: -24))
            make.centerY.equalToSuperview()
            make.width.equalTo(CGFloat.saiha.horizontalSize(num: 51))
        }
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func handleSwitch(sender: UISwitch) {
        sender.isOn = !sender.isOn
        self.handleSwitch?(sender)
    }
}
