//
//  SHAlertView.swift
//  Saiha
//
//  Created by 御前崎悠羽 on 2022/2/14.
//

import Foundation
import UIKit

open class SHAlertView: SHUIView {
    
    private var defaultConfirmButtonTitleColor: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { traitCollection in
                if traitCollection.userInterfaceStyle == .light {
                    return UIColor.systemBlue
                } else {
                    return UIColor.blue
                }
            }
        } else {
            return UIColor.blue
        }
    }
    
    private var defaultCancelButtonTitleColor: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { traitCollection in
                if traitCollection.userInterfaceStyle == .light {
                    return UIColor.systemRed
                } else {
                    return UIColor.red
                }
            }
        } else {
            return UIColor.red
        }
    }
    
    private var backgroundView: SHUIView = {
        let view: SHUIView = SHUIView()
        view.backgroundColor = UIColor.saiha_colorWithHexString("#000000", alpha: 0.7)
        return view
    }()
    
    open var mainContentView: SHUIView = {
        let view: SHUIView = SHUIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }()
    
    open var title: String? {
        didSet {
            self.titleLabel.text = title
        }
    }
    open lazy var titleLabel: SHUILabel = {
        let label: SHUILabel = SHUILabel()
        label.text = self.title
        label.font = .systemFont(ofSize: CGFloat.saiha_verticalSize(num: 17), weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private var cancelAction: (() -> Void)?
    open var cancelButton: SHUIButton = {
        let button: SHUIButton = SHUIButton()
        button.setTitle("取消", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: CGFloat.saiha_verticalSize(num: 17))
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    private var confirmAction: (() -> Void)?
    open var confirmButton: SHUIButton = {
        let button: SHUIButton = SHUIButton()
        button.setTitle("确认", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: CGFloat.saiha_verticalSize(num: 17))
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    var viewEdge: CGFloat = 22
    var leftViewEdge: CGFloat = 11
    var separatorEdge: CGFloat = 8.0
    var separatorColor: UIColor = UIColor.saiha_colorWithHexString("#F2F3F7")
    
    var allViews: [UIView] = []
    
    /// 控制点击背景视图是否会让弹框消失。
    public var touchBackgroundToCancel: Bool = false {
        didSet {
            if self.touchBackgroundToCancel {
                self.addBackgroundViewGesture()
            } else {
                self.removeBackgroundViewGesture()
            }
        }
    }
    private var tapGesture: UITapGestureRecognizer?
            
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.backgroundView)
        self.backgroundView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
        
        self.addSubview(self.mainContentView)
        self.mainContentView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(CGFloat.saiha_horizontalSize(num: 28))
            make.right.equalToSuperview().offset(CGFloat.saiha_horizontalSize(num: -27))
            make.centerY.equalToSuperview()
        }
        
        self.cancelButton.setTitleColor(self.defaultCancelButtonTitleColor, for: .normal)
        self.cancelButton.addTarget(self, action: #selector(self.handleCancelAction(sender:)), for: .touchUpInside)
        
        self.confirmButton.setTitleColor(self.defaultConfirmButtonTitleColor, for: .normal)
        self.confirmButton.addTarget(self, action: #selector(self.handleConfirmAction(sender:)), for: .touchUpInside)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @objc func handleCancelAction(sender: SHUIButton) {
        self.cancelAction?()
        self.dismiss()
    }
    
    @objc func handleConfirmAction(sender: SHUIButton) {
        self.confirmAction?()
        self.dismiss()
    }
    
    func dismiss() {
        self.isHidden = true
        self.removeFromSuperview()
    }
    
    func addBackgroundViewGesture() {
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleCancelAction(sender:)))
        self.tapGesture = tapGesture
        self.backgroundView.addGestureRecognizer(self.tapGesture!)
    }
    
    func removeBackgroundViewGesture() {
        if self.tapGesture != nil {
            self.backgroundView.removeGestureRecognizer(self.tapGesture!)
            self.tapGesture = nil
        }
    }
    
    func setUI() {
        for (index, view) in self.allViews.enumerated() {
            self.mainContentView.addSubview(view)
            
            if view == self.titleLabel {
                self.titleLabel.text = self.title
                view.snp.makeConstraints { make in
                    make.left.right.top.equalToSuperview()
                    make.height.equalTo(CGFloat.saiha_verticalSize(num: 56))
                }
                view.saiha_addSeparator(color: self.separatorColor, position: .bottom, leftEdge: self.separatorEdge, rightEdge: self.separatorEdge)
            } else {
                let preView: UIView? = index == 0 ? nil : self.allViews[index - 1]
                view.snp.remakeConstraints { make in
                    make.left.equalToSuperview().offset(CGFloat.saiha_verticalSize(num: self.leftViewEdge))
                    make.right.equalToSuperview().offset(CGFloat.saiha_verticalSize(num: -self.leftViewEdge))
                    if preView != nil {
                        make.top.equalTo(preView!.snp.bottom).offset(CGFloat.saiha_verticalSize(num: self.viewEdge))
                    } else {
                        make.top.equalToSuperview().offset(CGFloat.saiha_verticalSize(num: self.viewEdge))
                    }
                }
            }
        }
        
        let lastView: UIView? = self.allViews.last
        let firstButton: SHUIButton = self.cancelButton
        let secondButton: SHUIButton = self.confirmButton
        self.mainContentView.addSubview(firstButton)
        self.mainContentView.addSubview(secondButton)
        firstButton.snp.remakeConstraints { make in
            make.left.equalToSuperview()
            if lastView != nil {
                make.top.equalTo(lastView!.snp.bottom).offset(CGFloat.saiha_verticalSize(num: self.viewEdge))
            } else {
                make.top.equalToSuperview().offset(CGFloat.saiha_verticalSize(num: self.viewEdge))
            }
            make.height.equalTo(CGFloat.saiha_verticalSize(num: 58))
            make.width.equalTo(secondButton)
            make.right.equalTo(secondButton.snp.left)
            make.bottom.equalToSuperview().offset(CGFloat.saiha_verticalSize(num: 0))
        }
        secondButton.snp.remakeConstraints { make in
            make.right.equalToSuperview()
            make.top.equalTo(firstButton.snp.top)
            make.height.equalTo(CGFloat.saiha_verticalSize(num: 58))
            make.bottom.equalToSuperview().offset(CGFloat.saiha_verticalSize(num: 0))
        }
        firstButton.saiha_addSeparator(color: self.separatorColor, position: .top, leftEdge: self.separatorEdge, rightEdge: 0)
        secondButton.saiha_addSeparator(color: self.separatorColor, position: .top, leftEdge: 0, rightEdge: self.separatorEdge)
        let line: SHUIView = SHUIView()
        line.backgroundColor = self.separatorColor
        self.mainContentView.addSubview(line)
        line.snp.makeConstraints { make in
            make.left.equalTo(firstButton.snp.right)
            make.width.equalTo(1)
            make.top.equalTo(firstButton.snp.top).offset(CGFloat.saiha_verticalSize(num: 14))
            make.bottom.equalTo(firstButton.snp.bottom).offset(CGFloat.saiha_verticalSize(num: -14))
        }
    }
    
    func addView(title: String?, customView: UIView, inViewController: Bool = false, cancelAction: (() -> Void)?, confirmAction: @escaping (() -> Void)) {
        if inViewController {
            UIViewController.saiha_currentActivityViewController()?.view.addSubview(self)
        } else {
            UIWindow.saiha_securyWindow()?.addSubview(self)
        }
        self.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
        if title != nil {
            self.title = title
            self.allViews.insert(self.titleLabel, at: 0)
            self.allViews.insert(customView, at: 1)
        } else {
            self.allViews.insert(customView, at: 0)
        }
        self.cancelAction = cancelAction
        self.confirmAction = confirmAction
        self.setUI()
    }
}
