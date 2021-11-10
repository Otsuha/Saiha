//
//  SHContentSheetSwitchCell.swift
//  TXUtil
//
//  Created by 河瀬雫 on 2021/11/10.
//

import UIKit
import Saiha

open class SHContentSheetSwitchCell: UITableViewCell {
    
    open var showIcon: Bool = true

    private var label: UILabel!
    private var expressIcon: UIImageView!
    private var switchButton: UISwitch!
    
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        if self.showIcon {
            self.expressIcon = UIImageView()
            self.expressIcon.image = UIImage()
            self.expressIcon.contentMode = .scaleAspectFit
            self.contentView.addSubview(self.expressIcon)
            self.expressIcon.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(CGFloat.saiha.horizontalSize(num: 20))
                make.centerY.equalToSuperview()
                make.width.height.equalTo(CGFloat.saiha.verticalSize(num: 24))
            }
            
            self.label = UILabel()
            self.label.text = "中通快递"
            self.label.font = .systemFont(ofSize: CGFloat.saiha.verticalSize(num: 16))
            self.contentView.addSubview(self.label)
            self.label.snp.makeConstraints { make in
                make.left.equalTo(self.expressIcon.snp.right).offset(CGFloat.saiha.horizontalSize(num: 8))
                make.centerY.equalToSuperview()
                make.width.greaterThanOrEqualTo(CGFloat.saiha.horizontalSize(num: 64))
            }
        } else {
            self.label = UILabel()
            self.label.text = "中通快递"
            self.label.textAlignment = .left
            self.label.font = .systemFont(ofSize: CGFloat.saiha.verticalSize(num: 16))
            self.contentView.addSubview(self.label)
            self.label.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(CGFloat.saiha.horizontalSize(num: 20))
                make.centerY.equalToSuperview()
                make.width.greaterThanOrEqualTo(CGFloat.saiha.horizontalSize(num: 64))
            }
        }
        
        self.switchButton = UISwitch()
        //self.switchButton.tintColor = UIColor.saiha.colorWithHexString("#3951C4")
        self.switchButton.onTintColor = UIColor.saiha.colorWithHexString("#3951C4")
        self.contentView.addSubview(self.switchButton)
        self.switchButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(CGFloat.saiha.horizontalSize(num: -26))
            make.centerY.equalToSuperview()
            make.width.equalTo(CGFloat.saiha.horizontalSize(num: 51))
            make.height.equalTo(CGFloat.saiha.verticalSize(num: 31))
        }
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func changeSwitch(on: Bool) {
        self.switchButton.isOn = on
    }
    
    open func changeTitle(title: String) {
        self.label.text = title
    }
    
    open func changeIcon(icon: UIImage) {
        self.expressIcon.image = icon
    }
}
