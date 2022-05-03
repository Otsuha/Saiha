//
//  SHUITableView.swift
//  Saiha
//
//  Created by 御前崎悠羽 on 2021/11/7.
//

import UIKit
import IQKeyboardManagerSwift

public extension UITableView {
    
    enum SHStyle: Int {
        case plain = 0
        case grouped = 1
        case sidebar = 2
    }
    
}

open class SHUITableView: UITableView {
    
    private var _sh_style: SHUITableView.SHStyle!
    open var sh_style: SHUITableView.SHStyle {
        return self._sh_style
    }
    
    open var enableTouchToCancelAllEditing: Bool = true
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
    }

    public init(frame: CGRect, shStyle: SHUITableView.SHStyle) {
        switch shStyle {
        case .plain:
            super.init(frame: frame, style: .plain)
        case .grouped:
            super.init(frame: frame, style: .grouped)
        case .sidebar:
            super.init(frame: frame, style: .grouped)
            self._sh_style = shStyle
        }
        
        IQKeyboardManager.shared.enable = true
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        UIWindow.saiha_securyWindow()?.endEditing(self.enableTouchToCancelAllEditing)
    }
    
    deinit {
        IQKeyboardManager.shared.enable = false
    }
}
