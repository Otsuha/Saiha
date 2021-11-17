//
//  SHUILabel.swift
//  TXUtil
//
//  Created by 河瀬雫 on 2021/11/10.
//

import UIKit

open class SHUILabel: UILabel {

    private var helper: SaihaUILabelHelper {
        return SaihaUILabelHelper(label: self)
    }
    
}

public extension UILabel {

    static var saiha: SaihaUILabelHelper {
        return SaihaUILabelHelper(label: UILabel())
    }
}

open class SaihaUILabelHelper: SaihaUIViewHelper {
    
    var label: UILabel = UILabel()
    
    init(label: UILabel) {
        super.init(view: label)
        
        self.label = label
    }
    
    open func create(superView: UIView, _ creator: ((_ label: SaihaUILabelHelper) -> Void)) -> UILabel {
        creator(self)
        superView.addSubview(self.label)
        return self.label
    }
    
    open func frame(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) -> SaihaUILabelHelper {
        self.label.frame = CGRect(x: x, y: y, width: width, height: height)
        return self
    }
    
    open func text(text: String) -> SaihaUILabelHelper {
        self.label.text = text
        return self
    }
    
    open func font(size: CGFloat, weight: UIFont.Weight = .regular) -> SaihaUILabelHelper {
        self.label.font = .systemFont(ofSize: size, weight: weight)
        return self
    }
}

// MARK: - UILabel.

public extension SHUILabel {
    
    
}
