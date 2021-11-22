//
//  SHUIView.swift
//  Saiha
//
//  Created by 御前崎悠羽 on 2021/11/6.
//

import UIKit

open class SHUIView: UIView {

}

//public struct SaihaUIViewStaticHelper {
//
//
//
////    public func create(superView: UIView?, _ creator: ((_ label: SaihaUIViewHelper) -> Void)) -> UIView {
////        var view: UIView = UIView()
////        creator(SaihaUIViewHelper(view: view))
////        superView?.addSubview(view)
////        return view
////    }
////
////    public func create(superView: UIView?, _ creator: ((_ label: SaihaUILabelHelper) -> Void)) -> UILabel {
////        var label: UILabel = UILabel()
////        creator(SaihaUILabelHelper(label: label))
////        superView?.addSubview(label)
////        return label
////    }
//}
//
////extension UIView: SaihaUIViewDelegate {
////
////    public typealias ViewType = UIView
////
////    public static var saiha: SaihaUIViewHelper<ViewType> {
////        return SaihaUIViewHelper<ViewType>.init(view: ViewType())
////    }
////}
//
//public struct SaihaUIViewHelper {
//
//
//    private var view: ViewType
//
//    init(view: ViewType) {
//        self.view = view
//        self.helper = self
//    }
//
//    public func create(superView: UIView?, creator: ((_ view: SaihaUIViewHelper<ViewType>) -> Void)) -> ViewType {
//        creator(self)
//        superView?.addSubview(self.view)
//        return self.view
//    }
//
//    public func frame(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) -> HelperType {
//        self.view.frame = CGRect(x: x, y: y, width: width, height: height)
//        return helper
//    }
//
//    public func backgroundColor(_ color: UIColor) -> SaihaUIViewHelper<ViewType> {
//        self.view.backgroundColor = color
//        return self
//    }
//
//    public func end() {}
//
//    public func addRoundedCorners(rect: CGRect, corners: UIRectCorner, cornerRadii: CGSize) {
//        let rounded: UIBezierPath = UIBezierPath.init(roundedRect: self.view.bounds, byRoundingCorners: corners, cornerRadii: cornerRadii)
//        let shape: CAShapeLayer = CAShapeLayer()
//        shape.frame = self.view.bounds
//        shape.path = rounded.cgPath
//        self.view.layer.mask = shape
//    }
//
//    public func addSeparator(color: UIColor = UIColor.saiha.colorWithHexString("#F2F3F7"), position: SaihaUIViewHelper.SeparatorPositon = .bottom, leftEdge: CGFloat = 0, rightEdge: CGFloat = 0) {
//        let aLine: UIView = UIView()
//        aLine.backgroundColor = color
//        self.view.addSubview(aLine)
//        if position == .top {
//            aLine.snp.makeConstraints { make in
//                make.left.equalToSuperview().offset(leftEdge)
//                make.right.equalToSuperview().offset(-rightEdge)
//                make.top.equalToSuperview()
//                make.height.equalTo(1)
//            }
//        } else if position == .bottom {
//            aLine.snp.makeConstraints { make in
//                make.left.equalToSuperview().offset(leftEdge)
//                make.right.equalToSuperview().offset(-rightEdge)
//                make.bottom.equalToSuperview()
//                make.height.equalTo(1)
//            }
//        }
//    }
//}
//

extension UIView {
    
    public var saiha: SaihaNormalUIKitHelper {
        return SaihaNormalUIKitHelper(view: self)
    }
}

public struct SaihaNormalUIKitHelper {
    
    private var view: UIView
    
    init(view: UIView) {
        self.view = view
    }
    
    public func addRoundedCorners(rect: CGRect, corners: UIRectCorner, cornerRadii: CGSize) {
        let rounded: UIBezierPath = UIBezierPath.init(roundedRect: rect, byRoundingCorners: corners, cornerRadii: cornerRadii)
        let shape: CAShapeLayer = CAShapeLayer()
        shape.frame = self.view.bounds
        shape.path = rounded.cgPath
        self.view.layer.mask = shape
    }
}

public extension SaihaNormalUIKitHelper {

    enum SeparatorPositon {
        case top
        case bottom
    }
    
    public func addSeparator(color: UIColor = UIColor.saiha.colorWithHexString("#F2F3F7"),
                             position: SaihaNormalUIKitHelper.SeparatorPositon = .bottom,
                             leftEdge: CGFloat = 0, rightEdge: CGFloat = 0) {
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
