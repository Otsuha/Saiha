//
//  SHContentSheetView.swift
//  Saiha
//
//  Created by 河瀬雫 on 2021/11/10.
//

import UIKit

// MARK: - SHContentSheetView.

open class SHContentSheetView: SHUIView {
    
    private static var sharedView: SHContentSheetView?

    private var backgroundView: UIView!
    private var mainContentView: UIView!
    private var sepratorLine: UIView!
    private var cancelButton: UIButton!
    private var mainView: UIView!
    
    private var mainViewHeight: CGFloat = 0
    private var contentHeight: CGFloat {
        var height: CGFloat = self.mainViewHeight
        height += CGFloat.saiha_verticalSize(num: 56) + UIWindow.saiha_safeAreaInsets().bottom
        height += CGFloat.saiha_verticalSize(num: 8)
        return height
    }
    
    open var completionHandler: (() -> Void)?
    
    private static var actionTitle: String = "取消" {
        willSet {
            Self.sharedView?.cancelButton.setTitle(newValue, for: .normal)
        }
    }
    
    private let animationDuration: CGFloat = 0.6
            
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        self.backgroundView = UIView()
        self.backgroundView.backgroundColor = UIColor.saiha_colorWithHexString("#000000", alpha: 0.7)
        self.addSubview(self.backgroundView)
        self.backgroundView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
        
        self.mainContentView = UIView()
        self.backgroundView.addSubview(self.mainContentView)
        self.mainContentView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(0)
        }
        
        self.cancelButton = SHUIButton()
        self.cancelButton.backgroundColor = .white
        self.cancelButton.setTitle(Self.actionTitle, for: .normal)
        self.cancelButton.setTitleColor(.black, for: .normal)
        self.cancelButton.titleLabel?.bounds = self.cancelButton.bounds
        self.cancelButton.titleLabel?.textAlignment = .center
        self.cancelButton.titleLabel?.font = .systemFont(ofSize: CGFloat.saiha_verticalSize(num: 17))
        self.cancelButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: UIWindow.saiha_safeAreaInsets().bottom, right: 0)
        self.cancelButton.layer.backgroundColor = UIColor.white.cgColor
        self.cancelButton.addTarget(self, action: #selector(self.touchCancelAction(sender:)), for: .touchUpInside)
        self.mainContentView.addSubview(self.cancelButton)
        self.cancelButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.snp.bottom)
            make.height.equalTo(CGFloat.saiha_verticalSize(num: 56) + UIWindow.saiha_safeAreaInsets().bottom)
        }
        
        self.sepratorLine = UIView()
        self.sepratorLine.backgroundColor = UIColor.saiha_colorWithHexString("#F2F2F2")
        self.mainContentView.addSubview(self.sepratorLine)
        self.sepratorLine.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.cancelButton.snp.top)
            make.height.equalTo(CGFloat.saiha_verticalSize(num: 8))
        }
        
        self.mainView = UIView()
        self.mainView.backgroundColor = .white
        self.mainContentView.addSubview(self.mainView)
        self.mainView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.sepratorLine.snp.top).offset(0)
            make.height.equalTo(self.mainViewHeight)
        }
        
        self.mainContentView.clipsToBounds = true
    }
    
    /**
     该方法可以从底下弹出自定义视图，默认底下会有一个取消按钮。
     
     - Parameters:
        - customView: 自定义视图。
        - contentHeight: 自定义视图的高度。
     */
    public static func show(customView: UIView, contentHeight: CGFloat, completionHandler: ((() -> Void)?)) {
        if Self.sharedView?.superview != nil {
            return
        }
        let sheetView: SHContentSheetView = SHContentSheetView()
        sheetView.completionHandler = completionHandler
        sheetView.mainView.addSubview(customView)
        customView.snp.makeConstraints { make in
            make.left.top.right.bottom.equalToSuperview()
        }
        sheetView.mainViewHeight = contentHeight
        UIWindow.saiha_securyWindow()?.addSubview(sheetView)
        sheetView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
        sheetView.layer.cornerRadius = 10
        sheetView.mainContentView.layer.cornerRadius = 10
        sheetView.mainContentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        Self.sharedView = sheetView
        Self.sharedView?.showWithAnimation()
    }
    
    private func animationConfig(aniView: UIView, key: String, keyPath: String, from fromValue: CGFloat, to toValue: CGFloat, completionHandler: (() -> Void)?) {
        aniView.layer.removeAnimation(forKey: key)
        CATransaction.begin()
        let animation: CABasicAnimation = CABasicAnimation()
        animation.keyPath = keyPath
        animation.fromValue = fromValue
        animation.toValue = toValue
        animation.duration = CFTimeInterval(self.animationDuration)
        animation.isRemovedOnCompletion = true
        CATransaction.setCompletionBlock {
            completionHandler?()
        }
        aniView.layer.add(animation, forKey: key)
        CATransaction.commit()
    }
    
    private func positonYAnimationShow() {
        let fromValue: CGFloat = CGFloat.saiha_screenHeight + self.contentHeight / 2
        let toValue: CGFloat = CGFloat.saiha_screenHeight - self.contentHeight + self.contentHeight / 2
        self.animationConfig(aniView: self.mainContentView, key: "positionY.animation.show", keyPath: "position.y", from: fromValue, to: toValue, completionHandler: nil)
    }
    
    private func positonYAnimationDismiss() {
        let fromValue: CGFloat = CGFloat.saiha_screenHeight - self.contentHeight + self.contentHeight / 2
        let toValue: CGFloat = CGFloat.saiha_screenHeight + self.contentHeight / 2
        self.animationConfig(aniView: self.mainContentView, key: "positionY.animation.dismiss", keyPath: "position.y", from: fromValue, to: toValue) {
            self.dismissAllView()
        }
    }
    
    private func opacityAnimationShow() {
        let fromValue: CGFloat = 0.0
        let toValue: CGFloat = 1.0
        self.animationConfig(aniView: self.mainContentView, key: "opacity.animation.show", keyPath: "opacity", from: fromValue, to: toValue, completionHandler: nil)
        self.animationConfig(aniView: self.backgroundView, key: "opacity.animation.show.backgroundView", keyPath: "opacity", from: fromValue, to: toValue, completionHandler: nil)
    }
    
    private func opacityAnimationDismiss() {
        let fromValue: CGFloat = 1.0
        let toValue: CGFloat = 0.0
        self.animationConfig(aniView: self.mainContentView, key: "opacity.animation.dismiss", keyPath: "opacity", from: fromValue, to: toValue, completionHandler: nil)
        self.animationConfig(aniView: self.backgroundView, key: "opacity.animation.dismiss.backgroundView", keyPath: "opacity", from: fromValue, to: toValue, completionHandler: nil)
    }
    
    /// 自定义底部按钮标题。
    public static func setActionTitle(_ text: String) {
        Self.actionTitle = text
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        self.mainView.snp.updateConstraints { make in
            make.height.equalTo(self.mainViewHeight)
        }
        
        self.mainContentView.snp.updateConstraints { make in
            make.height.equalTo(self.contentHeight)
        }
    }

    private func showWithAnimation() {
        self.positonYAnimationShow()
        self.opacityAnimationShow()
    }
    
    private func dismissWithAnimation() {
        self.positonYAnimationDismiss()
        self.opacityAnimationDismiss()
    }
    
    private func dismissAllView() {
        self.removeFromSuperview()
        Self.sharedView?.removeFromSuperview()
        Self.sharedView = nil
    }
    
    @objc private func touchCancelAction(sender: UIButton) {
        self.dismissWithAnimation()
        self.completionHandler?()
    }
    
    public static func dismiss() {
        Self.sharedView?.dismissWithAnimation()
    }
}
