//
//  SHCGFloat.swift
//  Saiha
//
//  Created by 御前崎悠羽 on 2021/11/6.
//

import UIKit

public extension CGFloat {
    
    static var saiha: SaihaCGFloat {
        return SaihaCGFloat(cgFloat: CGFloat())
    }
}

public struct SaihaCGFloat {
    
    let shCGFloat: CGFloat
    
    init(cgFloat: CGFloat) {
        self.shCGFloat = cgFloat
    }
    
    public var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    public var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    public func levelRatio() -> CGFloat {
        return self.screenWidth / 375.0
    }
    
    public func verticalRatio() -> CGFloat {
        return self.screenHeight / 812.0
    }
    
    public func levelSize(num: CGFloat) -> CGFloat {
        return self.levelRatio() * num
    }
    
    public func verticalSize(num: CGFloat) -> CGFloat {
        return self.verticalRatio() * num
    }
}
