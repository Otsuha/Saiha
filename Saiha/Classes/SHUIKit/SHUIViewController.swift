//
//  SHUIViewController.swift
//  Saiha
//
//  Created by 御前崎悠羽 on 2021/11/6.
//

import UIKit

// MARK: - SHUIViewController.

public extension UIViewController {
    
    static var saiha: SHUIViewControllerHelper {
        return SHUIViewControllerHelper()
    }
}

open class SHUIViewController: UIViewController {
    
    // MARK: - UIViewController.

    open override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - deinit.
        
    deinit {
        print("\(NSStringFromClass(self.classForCoder)) 已释放。")
        NotificationCenter.default.removeObserver(self)
    }

}

// MARK: - SHUIViewControllerHelper.

public class SHUIViewControllerHelper {
    
    public func currentActivityViewController() -> UIViewController? {
        let rootViewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController
        guard let rootVC = rootViewController else {
            return nil
        }
        return self.findCurrentActivityViewController(from: rootVC)
    }
    
    public func findCurrentActivityViewController(from viewController: UIViewController) -> UIViewController? {
        var currentActivityViewController: UIViewController?
        
        // 先判断根视图控制器是否有其他视图控制器弹出，如果有，那么当前的视图控制器肯定在它之上。
        if viewController.presentedViewController != nil {
            let nextRootVC: UIViewController? = viewController.presentedViewController
            if nextRootVC != nil {
                currentActivityViewController = self.findCurrentActivityViewController(from: nextRootVC!)
            } else {
                return nil
            }
            
        } else if viewController.isKind(of: UITabBarController.self) {
            let nextRootVC: UIViewController? = (viewController as! UITabBarController).selectedViewController
            if nextRootVC != nil {
                currentActivityViewController = self.findCurrentActivityViewController(from: nextRootVC!)
            } else {
                return nil
            }
        } else if viewController.isKind(of: UINavigationController.self) {
            let nextRootVC: UIViewController? = (viewController as! UINavigationController).visibleViewController
            if nextRootVC != nil {
                currentActivityViewController = self.findCurrentActivityViewController(from: nextRootVC!)
            } else {
                return nil
            }
        } else {
            // 根视图为非导航类。
            currentActivityViewController = viewController
        }
        
        return currentActivityViewController
    }
}
