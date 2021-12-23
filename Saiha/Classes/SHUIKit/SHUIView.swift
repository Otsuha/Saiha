//
//  SHUIView.swift
//  Saiha
//
//  Created by 御前崎悠羽 on 2021/11/6.
//

import UIKit

open class SHUIView: UIView {

}

extension UIView {
    
    public func saiha_addRoundedCorners(rect: CGRect, corners: UIRectCorner, cornerRadii: CGSize) {
        self.layer.cornerRadius = cornerRadii.width
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}

public extension UIView {
    
    enum CornerPosition {
        case topLeft
        case topRight
        case bottomLeft
        case bottomRight
        case all
    }
    
    public func addRoundedCorners(cornerPositons: [UIView.CornerPosition], radius: CGFloat) {
        var corners: UInt = CACornerMask().rawValue
        for corner in cornerPositons {
            switch corner {
            case .topLeft:
                corners = corners | CACornerMask.layerMinXMinYCorner.rawValue
            case .topRight:
                corners = corners | CACornerMask.layerMaxXMinYCorner.rawValue
            case .bottomLeft:
                corners = corners | CACornerMask.layerMinXMaxYCorner.rawValue
            case .bottomRight:
                corners = corners | CACornerMask.layerMaxXMaxYCorner.rawValue
            case .all:
                corners = CACornerMask().rawValue
            }
        }
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = CACornerMask(rawValue: corners) // Fallback on earlier versions
    }
    
}

public extension UIView {

    enum SeparatorPositon {
        case top
        case bottom
    }
    
    public func saiha_addSeparator(color: UIColor = UIColor.saiha_colorWithHexString("#F2F3F7"),
                             position: UIView.SeparatorPositon = .bottom,
                             leftEdge: CGFloat = 0, rightEdge: CGFloat = 0) {
        let aLine: UIView = UIView()
        aLine.backgroundColor = color
        self.addSubview(aLine)
        if position == .top {
            aLine.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(leftEdge)
                make.right.equalToSuperview().offset(-rightEdge)
                make.top.equalToSuperview()
                make.height.equalTo(1)
            }
        } else if position == .bottom {
            aLine.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(leftEdge)
                make.right.equalToSuperview().offset(-rightEdge)
                make.bottom.equalToSuperview()
                make.height.equalTo(1)
            }
        }
    }
}
