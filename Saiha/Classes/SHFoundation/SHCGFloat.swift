//
//  SHCGFloat.swift
//  Saiha
//
//  Created by 御前崎悠羽 on 2021/11/6.
//

import UIKit

public extension CGFloat {
    
    public static var saiha_screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    public static var saiha_screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    public static func saiha_horizontalRatio() -> CGFloat {
        return self.saiha_screenWidth / 375.0
    }
    
    public static func saiha_verticalRatio() -> CGFloat {
        return self.saiha_screenHeight / 812.0
    }
    
    public static func saiha_horizontalSize(num: CGFloat) -> CGFloat {
        return self.saiha_horizontalRatio() * num
    }
    
    public static func saiha_verticalSize(num: CGFloat) -> CGFloat {
        return self.saiha_verticalRatio() * num
    }
    
}
