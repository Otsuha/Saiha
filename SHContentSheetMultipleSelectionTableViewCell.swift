//
//  SHContentSheetMultipleSelectionTableViewCell.swift
//  Saiha
//
//  Created by 河瀬雫 on 2022/1/10.
//

import Foundation

open class SHContentSheetMultipleSelectionTableViewCell: SHContentSheetTableViewCell {
    
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
    
    open var showMark: Bool = false  // 多选视图下是否显示选中后的打钩标记。
    
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.contentView.addSubview(self.markButton)
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
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
