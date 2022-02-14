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
    
    private var viewEdge: CGFloat = 30
    private var leftViewEdge: CGFloat = 15
    private var separatorEdge: CGFloat = 8.0
    private var separatorColor: UIColor = UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1.0)
    
    private var allViews: [UIView] = []
    
    private var actionSave: [SHUIButton] = []
        
    public var buttonSave: [SHUIButton] = []
    private var actionDic: [SHUIButton: (() -> Void)] = [:]
    
    public var textFieldSave: [SHUITextField] = []
    
    public var labelSave: [SHUILabel] = []
    
    /// 设置警告框的每个组件之间是否有分割线。
    public var showSeparator: Bool = true
    
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
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func dismiss() {
        self.isHidden = true
        self.removeFromSuperview()
    }
    
    public func addTextField(placeholder: String, textFieldConfiguration: ((_ textField: SHUITextField) -> Void)?) {
        let textField: SHUITextField = SHUITextField()
        textField.placeholder = placeholder
        textField.layer.borderColor = UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1.0).cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10
        textField.clearButtonMode = .whileEditing
        textField.borderStyle = .roundedRect
        textFieldConfiguration?(textField)
        self.textFieldSave.append(textField)
        self.allViews.append(textField)
    }
    
    public func addLabel(text: String, labelConfiguration: ((_ label: SHUILabel) -> Void)?) {
        let label: SHUILabel = SHUILabel()
        label.text = text
        label.numberOfLines = 0
        self.labelSave.append(label)
        labelConfiguration?(label)
        self.allViews.append(label)
    }
    
    public func addAction(title: String, buttonConfiguration: @escaping ((_ button: SHUIButton) -> Void), completionHandler: @escaping (() -> Void)) {
        let button: SHUIButton = SHUIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: CGFloat.saiha_verticalSize(num: 17))
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(self.handleButtonAction(sender:)), for: .touchUpInside)
        buttonConfiguration(button)
        self.actionDic[button] = completionHandler
        self.actionSave.append(button)
    }
    
    @objc private func handleButtonAction(sender: SHUIButton) {
        let completionHandler: (() -> Void)? = self.actionDic[sender]
        completionHandler?()
        self.dismiss()
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
                
                if view.isKind(of: SHUITextField.self) {
                    view.snp.remakeConstraints { make in
                        make.left.equalToSuperview().offset(CGFloat.saiha_verticalSize(num: self.leftViewEdge))
                        make.right.equalToSuperview().offset(CGFloat.saiha_verticalSize(num: -self.leftViewEdge))
                        if preView != nil {
                            make.top.equalTo(preView!.snp.bottom).offset(CGFloat.saiha_verticalSize(num: self.viewEdge))
                        } else {
                            make.top.equalToSuperview().offset(CGFloat.saiha_verticalSize(num: self.viewEdge))
                        }
                        make.height.equalTo(CGFloat.saiha_verticalSize(num: 48))
                    }
                    if self.showSeparator {
                        let line: SHUIView = SHUIView()
                        line.backgroundColor = self.separatorColor
                        self.mainContentView.addSubview(line)
                        line.snp.makeConstraints { make in
                            make.left.equalToSuperview().offset(self.separatorEdge)
                            make.right.equalToSuperview().offset(-self.separatorEdge)
                            make.top.equalTo(view.snp.bottom).offset(self.viewEdge)
                            make.height.equalTo(1)
                        }
                        self.allViews[index] = line
                    }
                } else if view.isKind(of: SHUILabel.self) {
                    view.snp.remakeConstraints { make in
                        make.left.equalToSuperview().offset(CGFloat.saiha_horizontalSize(num: self.leftViewEdge))
                        make.right.equalToSuperview().offset(CGFloat.saiha_horizontalSize(num: -self.leftViewEdge))
                        if preView != nil {
                            make.top.equalTo(preView!.snp.bottom).offset(CGFloat.saiha_verticalSize(num: self.viewEdge))
                        } else {
                            make.top.equalToSuperview().offset(CGFloat.saiha_verticalSize(num: self.viewEdge))
                        }
                    }
                    if self.showSeparator {
                        let line: SHUIView = SHUIView()
                        line.backgroundColor = self.separatorColor
                        self.mainContentView.addSubview(line)
                        line.snp.makeConstraints { make in
                            make.left.equalToSuperview().offset(self.separatorEdge)
                            make.right.equalToSuperview().offset(-self.separatorEdge)
                            make.top.equalTo(view.snp.bottom).offset(self.viewEdge)
                            make.height.equalTo(1)
                        }
                        self.allViews[index] = line
                    }
                }
            }
        }
        
        let lastView: UIView? = self.allViews.last
        if self.actionSave.count == 2 {
            let firstButton: SHUIButton = self.actionSave[0]
            let secondButton: SHUIButton = self.actionSave[1]
            self.mainContentView.addSubview(firstButton)
            self.mainContentView.addSubview(secondButton)
            firstButton.snp.remakeConstraints { make in
                make.left.equalToSuperview()
                if lastView != nil {
                    make.top.equalTo(lastView!.snp.bottom).offset(CGFloat.saiha_verticalSize(num: 0))
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
            let line: SHUIView = SHUIView()
            line.backgroundColor = self.separatorColor
            self.mainContentView.addSubview(line)
            line.snp.makeConstraints { make in
                make.left.equalTo(firstButton.snp.right)
                make.width.equalTo(1)
                make.top.equalTo(firstButton.snp.top).offset(CGFloat.saiha_verticalSize(num: 14))
                make.bottom.equalTo(firstButton.snp.bottom).offset(CGFloat.saiha_verticalSize(num: -14))
            }
        } else {
            for (index, view) in self.actionSave.enumerated() {
                self.mainContentView.addSubview(view)
                let isLastView: Bool = index == self.actionSave.count - 1 ? true : false
                var preView: UIView?
                if index == 0 {
                    preView = lastView
                } else {
                    preView = self.actionSave.count > 1 ? self.actionSave[index - 1] : nil
                }
                view.snp.remakeConstraints { make in
                    make.left.right.equalToSuperview()
                    if preView != nil {
                        make.top.equalTo(preView!.snp.bottom).offset(CGFloat.saiha_verticalSize(num: 0))
                    } else {
                        make.top.equalToSuperview().offset(CGFloat.saiha_verticalSize(num: self.viewEdge))
                    }
                    make.height.equalTo(CGFloat.saiha_verticalSize(num: 58))
                }
                if isLastView {
                    view.snp.makeConstraints { make in
                        make.bottom.equalToSuperview().offset(CGFloat.saiha_verticalSize(num: 0))
                    }
                } else {
                    view.saiha_addSeparator(color: self.separatorColor, position: .bottom, leftEdge: self.separatorEdge, rightEdge: self.separatorEdge)
                }
            }
        }
    }
    
    public static func show(title: String?, inViewController: Bool = false, alertViewConfiguration: @escaping ((_ alertView: SHAlertView) -> Void)) {
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
        }
        alertViewConfiguration(alertView)
        alertView.setUI()
    }
    
}
