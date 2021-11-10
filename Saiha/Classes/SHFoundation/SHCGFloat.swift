//
//  SHCGFloat.swift
//  Saiha
//
//  Created by 御前崎悠羽 on 2021/11/6.
//

import UIKit

public extension CGFloat {
    
    static var saiha: SaihaCGFloat {
        return SaihaCGFloat()
    }
}

public struct SaihaCGFloat {
    
    public var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    public var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    public func horizontalRatio() -> CGFloat {
        return self.screenWidth / 375.0
    }
    
    public func verticalRatio() -> CGFloat {
        return self.screenHeight / 812.0
    }
    
    public func horizontalSize(num: CGFloat) -> CGFloat {
        return self.horizontalRatio() * num
    }
    
    public func verticalSize(num: CGFloat) -> CGFloat {
        return self.verticalRatio() * num
    }
}
