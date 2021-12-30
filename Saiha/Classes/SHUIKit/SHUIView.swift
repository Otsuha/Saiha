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
    
    /**
     利用 `CABasicAnimation` 产生一次简单的动画。动画在完成后会自动移除。
     */
    public func saiha_addSimpleOnceAnimation(key: String, keyPath: String, from fromValue: CGFloat, to toValue: CGFloat, duration: CGFloat, completionHandler: (() -> Void)?) {
        self.layer.removeAnimation(forKey: key)
        CATransaction.begin()
        let animation: CABasicAnimation = CABasicAnimation()
        animation.keyPath = keyPath
        animation.fromValue = fromValue
        animation.toValue = toValue
        animation.duration = CFTimeInterval(duration)
        animation.isRemovedOnCompletion = true
        CATransaction.setCompletionBlock {
            completionHandler?()
        }
        self.layer.add(animation, forKey: key)
        CATransaction.commit()
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
    
    public func saiha_addRoundedCorners(cornerPositons: [UIView.CornerPosition], radius: CGFloat) {
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
        if #available(iOS 11.0, *) {
            self.layer.cornerRadius = radius
            self.layer.maskedCorners = CACornerMask(rawValue: corners)
        } else {
            
        }
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
