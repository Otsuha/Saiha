//
//  SHUIWindow.swift
//  Saiha
//
//  Created by 河瀬雫 on 2021/11/10.
//

import UIKit

open class SHUIWindow: UIWindow {

}

public extension UIWindow {
    
    static var saiha: SaihaUIWindowHelper {
        return SaihaUIWindowHelper()
    }
}

public struct SaihaUIWindowHelper {
    
    public func securyWindow() -> UIWindow? {
        if  #available(iOS 13.0, *) {
            for item in UIApplication.shared.connectedScenes where item is UIWindowScene {
                if item.activationState == .foregroundActive {
                    guard let windowScene = item as? UIWindowScene else {
                        return nil
                    }
                    for window in windowScene.windows {
                        if window.isKeyWindow {
                            return window
                        }
                    }
                    return nil
                }
            }
        }else{
            return UIApplication.shared.keyWindow
        }
        return UIApplication.shared.windows.last
    }
}
