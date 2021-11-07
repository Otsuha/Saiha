//
//  SHUITableView.swift
//  Saiha
//
//  Created by 御前崎悠羽 on 2021/11/7.
//

import UIKit

public extension UITableView {
    
    public enum SHStyle: Int {
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
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
