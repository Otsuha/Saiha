//
//  SHUILabel.swift
//  TXUtil
//
//  Created by 河瀬雫 on 2021/11/10.
//

import UIKit

open class SHUILabel: UILabel {
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        self.textColor = UIColor.defaultLabelColor
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

//extension UILabel: SaihaUIViewDelegate {
//
//    public typealias ViewType = UILabel
//
//    public static var saiha: SaihaUIViewHelper<ViewType> {
//        return SaihaUILabelHelper<ViewType>.init(label: ViewType())
//    }
//}

//public class SaihaUILabelHelper: SaihaUIViewHelper<SHUILabel> {
//
//    private var label: SHUILabel
//
//    override init(view: SHUILabel) {
//        self.label = view
//        super.init(view: view)
//    }
//
//    public override func create(superView: UIView?, creator: ((_ label: SaihaUILabelHelper) -> Void)) -> SHUILabel {
//        creator(self)
//        superView?.addSubview(self.label)
//        return self.label
//    }
//
//    public func text(text: String) -> SaihaUILabelHelper {
//        self.label.text = text
//        return self
//    }
//
//    public func font(size: CGFloat, weight: UIFont.Weight = .regular) -> SaihaUILabelHelper {
//        self.label.font = .systemFont(ofSize: size, weight: weight)
//        return self
//    }
//
//    public func textAlignment(_ alignment: NSTextAlignment) -> SaihaUILabelHelper {
//        self.label.textAlignment = alignment
//        return self
//    }
//
//    public func textColor(_ color: UIColor) -> SaihaUILabelHelper {
//        self.label.textColor = color
//        return self
//    }
//
//    public func lineBreakMode(_ mode: NSLineBreakMode, numberOfLines: Int) -> SaihaUILabelHelper {
//        self.label.lineBreakMode = mode
//        self.label.numberOfLines = numberOfLines
//        return self
//    }
//}
