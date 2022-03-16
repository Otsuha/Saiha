//
//  SHAlertView.swift
//  Saiha
//
//  Created by 御前崎悠羽 on 2022/2/14.
//

import Foundation
import UIKit

open class SHAlertView: SHUIView {
    
    private var backgroundView: SHUIView = {
        let view: SHUIView = SHUIView()
        view.backgroundColor = UIColor.saiha_colorWithHexString("#000000", alpha: 0.7)
        return view
    }()
    
    private var mainContentView: SHUIView = {
        let view: SHUIView = SHUIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }()
    
    private var title: String?
    private lazy var titleLabel: SHUILabel = {
        let label: SHUILabel = SHUILabel()
        label.text = self.title
        label.font = .systemFont(ofSize: CGFloat.saiha_verticalSize(num: 17))
        label.textAlignment = .center
        return label
    }()
    
    private var cancelAction: ((_ button: SHUIButton) -> Void)?
    private var cancelButton: SHUIButton = {
        let button: SHUIButton = SHUIButton()
        button.setTitle("取消", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: CGFloat.saiha_verticalSize(num: 17))
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    private var confirmAction: ((_ button: SHUIButton) -> Void)?
    private var confirmButton: SHUIButton = {
        let button: SHUIButton = SHUIButton()
        button.setTitle("确认", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: CGFloat.saiha_verticalSize(num: 17))
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    private var viewEdge: CGFloat = 15
    private var leftViewEdge: CGFloat = 15
    private var separatorEdge: CGFloat = 8.0
    private var separatorColor: UIColor = UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1.0)
    
    private var allViews: [UIView] = []
            
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
        
        self.cancelButton.addTarget(self, action: #selector(self.handleCancelAction(sender:)), for: .touchUpInside)
        self.confirmButton.addTarget(self, action: #selector(self.handleConfirmAction(sender:)), for: .touchUpInside)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @objc private func handleCancelAction(sender: SHUIButton) {
        self.cancelAction?(self.cancelButton)
        self.dismiss()
    }
    
    @objc private func handleConfirmAction(sender: SHUIButton) {
        self.confirmAction?(self.confirmButton)
        self.dismiss()
    }
    
    private func dismiss() {
        self.isHidden = true
        self.removeFromSuperview()
    }
    
    private func setUI() {
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
    
    public static func show(title: String?, customView: UIView, inViewController: Bool = false, cancelAction: ((_ button: SHUIButton) -> Void)?, confirmAction: @escaping ((_ button: SHUIButton) -> Void)) {
        let alertView: SHAlertView = SHAlertView()
        if inViewController {
            UIViewController.saiha_currentActivityViewController()?.view.addSubview(alertView)
        } else {
            UIWindow.saiha_securyWindow()?.addSubview(alertView)
        }
        alertView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
        if title != nil {
            alertView.title = title
            alertView.allViews.insert(alertView.titleLabel, at: 0)
            alertView.allViews.insert(customView, at: 1)
        } else {
            alertView.allViews.insert(customView, at: 0)
        }
        alertView.cancelAction = cancelAction
        alertView.confirmAction = confirmAction
        alertView.setUI()
    }
    
}
