//
//  SHUIColor.swift
//  Saiha
//
//  Created by 御前崎悠羽 on 2021/11/6.
//

import UIKit

public extension UIColor {
    
    static var saiha: SaihaUIColor = SaihaUIColor(color: UIColor())
}

public struct SaihaUIColor {
    
    let shColor: UIColor
    
    init(color: UIColor) {
        self.shColor = color
    }
    
    public func colorWithHexString(_ hex: String) -> UIColor {
        self.colorWithHexString(hex, alpha: 1.0)
    }
    
    public func colorWithHexString(_ hex: String, alpha: CGFloat) -> UIColor {
        var cString: String = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        }

        if cString.count != 6 {
            return UIColor.gray
        }

        let rString: String = (cString as NSString).substring(to: 2)
        let gString: String = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString: String = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)

        var r: CUnsignedInt = 0, g: CUnsignedInt = 0, b: CUnsignedInt = 0
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)

        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }
}
