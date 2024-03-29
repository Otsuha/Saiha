//
//  SHSingleButtonMessageAlertView.swift
//  Saiha
//
//  Created by 御前崎悠羽 on 2022/4/6.
//

import Foundation
import UIKit

open class SHSingleButtonMessageAlertView: SHSingleButtonAlertView {
    
    private var contentView: SHUIView = {
        let view: SHUIView = SHUIView()
        view.backgroundColor = UIColor.defaultViewColor
        return view
    }()
    
    open var label: SHUILabel = {
        let label: SHUILabel = SHUILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.contentView)
        
        self.contentView.addSubview(self.label)
        self.label.snp.makeConstraints { make in
            make.left.top.right.bottom.equalToSuperview()
            make.height.greaterThanOrEqualTo(65)
        }
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    /**
     带消息提示 `label` 的警告框，底部有一个按钮。
     
     - Parameters:
        - title: 警告弹框标题。若为 `nil` 则不显示标题行。
        - message: 需要提示的消息。
        - inViewController: 默认弹框视图添加在主窗口上，但是你也可以选择将视图添加在当前活跃的控制器上。
        - viewConfiguration: 可以对弹框视图进行某些设置。
        - confirmAction: 点击底部确定按钮的事件。
     */
    public static func show(title: String?, message: String, inViewController: Bool = false, viewConfiguration: ((_ messageAlertView: SHSingleButtonMessageAlertView) -> Void)?, confirmAction: @escaping (() -> Void)) {
        let messageAlertView: SHSingleButtonMessageAlertView = SHSingleButtonMessageAlertView()
        messageAlertView.label.text = message
        viewConfiguration?(messageAlertView)
        messageAlertView.addView(title: title, customView: messageAlertView.contentView, inViewController: inViewController, cancelAction: nil, confirmAction: confirmAction)
    }
}
