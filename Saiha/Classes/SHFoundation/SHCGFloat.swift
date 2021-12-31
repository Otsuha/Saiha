//
//  SHCGFloat.swift
//  Saiha
//
//  Created by 御前崎悠羽 on 2021/11/6.
//

import UIKit

public extension CGFloat {
    
    static var saiha_screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    static var saiha_screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    static func saiha_horizontalRatio() -> CGFloat {
        return self.saiha_screenWidth / 375.0
    }
    
    static func saiha_verticalRatio() -> CGFloat {
        return self.saiha_screenHeight / 812.0
    }
    
    static func saiha_horizontalSize(num: CGFloat) -> CGFloat {
        return self.saiha_horizontalRatio() * num
    }
    
    static func saiha_verticalSize(num: CGFloat) -> CGFloat {
        return self.saiha_verticalRatio() * num
    }
    
}
