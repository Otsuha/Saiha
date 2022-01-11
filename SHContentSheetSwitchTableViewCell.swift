//
//  SHContentSheetSwitchTableViewCell.swift
//  Saiha
//
//  Created by 河瀬雫 on 2022/1/11.
//

import Foundation
import UIKit

open class SHContentSheetSwitchTableViewCell: SHContentSheetTableViewCell {
    
    open var switchButton: UISwitch = {
        let switchButton: UISwitch = UISwitch()
        switchButton.isOn = true
        return switchButton
    }()
    
    open var switchAllowTouch: Bool = true {
        willSet {
            self.switchButton.isUserInteractionEnabled = newValue
        }
    }
    
    open var handleSwitch: ((_ switchButton: UISwitch) -> Void)?
    
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.widgeAlignment = .left
        
        self.switchButton.addTarget(self, action: #selector(self.handleSwitch(sender:)), for: .valueChanged)
        self.contentView.addSubview(self.switchButton)
        self.switchButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(CGFloat.saiha_verticalSize(num: -24))
            make.centerY.equalToSuperview()
            make.width.equalTo(CGFloat.saiha_horizontalSize(num: 51))
        }
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func handleSwitch(sender: UISwitch) {
        self.handleSwitch?(sender)
    }
}
