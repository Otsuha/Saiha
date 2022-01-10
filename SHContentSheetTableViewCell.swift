//
//  SHContentSheetTableViewCell.swift
//  Saiha
//
//  Created by 河瀬雫 on 2022/1/10.
//

import Foundation

open class SHContentSheetTableViewCell: UITableViewCell {
    
    public enum WidgeAlignment: Int {
        case left
        case center
    }
    
    open var iconImageView: UIImageView?
    open var titleLabel: SHUILabel!
    
    open var showIcon: Bool = true
    
    private var hasAddSeparator: Bool = false
    open var showSeparator: Bool = true
    
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
    }
}
