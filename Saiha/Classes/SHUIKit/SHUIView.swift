//
//  SHUIView.swift
//  Saiha
//
//  Created by 御前崎悠羽 on 2021/11/6.
//

import UIKit

open class SHUIView: UIView {
    
}

public extension UIView {
    
    var saiha: SaihaUIViewHelper {
        return SaihaUIViewHelper(view: self)
    }
}

public struct SaihaUIViewHelper {
    
    let view: UIView
    
    init(view: UIView) {
        self.view = view
    }
    
    public func addRoundedCorners(rect: CGRect, corners: UIRectCorner, cornerRadii: CGSize) {
        let rounded: UIBezierPath = UIBezierPath.init(roundedRect: self.view.bounds, byRoundingCorners: corners, cornerRadii: cornerRadii)
        let shape: CAShapeLayer = CAShapeLayer()
        shape.frame = self.view.bounds
        shape.path = rounded.cgPath
        self.view.layer.mask = shape
    }
    
    public func addSeparator(color: UIColor, position: SaihaUIViewHelper.SeparatorPositon, leftEdge: CGFloat, rightEdge: CGFloat) {
        let aLine: UIView = UIView()
        aLine.backgroundColor = color
        self.view.addSubview(aLine)
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

public extension SaihaUIViewHelper {
    
    enum SeparatorPositon {
        case top
        case bottom
    }
}
