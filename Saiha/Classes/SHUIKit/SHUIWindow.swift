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
    
    static func saiha_securyWindow() -> UIWindow? {
        if #available(iOS 13.0, *) {
            if let window = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first{
                return window
            }else if let window = UIApplication.shared.delegate?.window{
                return window
            }else{
                return nil
            }
        } else {
            if let window = UIApplication.shared.delegate?.window{
                return window
            }else{
                return nil
            }
        }
    }
    
    static func saiha_safeAreaInsets() -> UIEdgeInsets {
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
