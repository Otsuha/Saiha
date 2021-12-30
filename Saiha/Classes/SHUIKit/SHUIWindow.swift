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
    
    public static func saiha_securyWindow() -> UIWindow? {
        var resultWindow: UIWindow? = UIApplication.shared.windows.last
        DispatchQueue.main.async {
            if #available(iOS 13.0, *) {
                for item in UIApplication.shared.connectedScenes where item is UIWindowScene {
                    if item.activationState == .foregroundActive {
                        guard let windowScene = item as? UIWindowScene else {
                            resultWindow = nil
                            return
                        }
                        for window in windowScene.windows {
                            if window.isKeyWindow {
                                resultWindow = window
                            }
                        }
                        resultWindow = nil
                    }
                }
            } else {
                resultWindow = UIApplication.shared.keyWindow
            }
        }
        return resultWindow
    }
    
    public static func saiha_safeAreaInsets() -> UIEdgeInsets {
        guard let window = UIWindow.saiha_securyWindow(), let rootViewController = window.rootViewController else {
            return UIEdgeInsets.zero
        }
        if #available(iOS 11.0, *) {
            return rootViewController.view.safeAreaInsets
        } else {
            return UIEdgeInsets.zero
        }
    }
}
