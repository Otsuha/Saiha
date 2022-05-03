//
//  SHInputAlertView.swift
//  Saiha
//
//  Created by 御前崎悠羽 on 2022/3/15.
//

import Foundation

open class SHInputAlertView: SHAlertView {
    
    private var contentView: SHUIView = {
        let view: SHUIView = SHUIView()
        view.backgroundColor = UIColor.defaultViewColor
        return view
    }()
    
    open var textField: SHUITextField = {
        let textField: SHUITextField = SHUITextField()
        textField.layer.borderColor = UIColor(red: 230 / 255.0, green: 230 / 255.0, blue: 230 / 255.0, alpha: 1.0).cgColor
        textField.layer.borderWidth = 0.5
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    private var confirmActionWithView: ((_ inputAlertView: SHInputAlertView) -> Void)?
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.contentView)
        
        self.contentView.addSubview(self.textField)
        self.textField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(CGFloat.saiha_horizontalSize(num: 22))
            make.right.equalToSuperview().offset(CGFloat.saiha_horizontalSize(num: -22))
            make.top.equalToSuperview().offset(CGFloat.saiha_verticalSize(num: 22))
            make.bottom.equalToSuperview().offset(CGFloat.saiha_verticalSize(num: -12))
            make.height.equalTo(CGFloat.saiha_verticalSize(num: 48))
        }
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func handleConfirmAction(sender: SHUIButton) {
        self.confirmActionWithView?(self)
        self.dismiss()
    }
    
    public static func show(title: String?, placeholder: String, inViewController: Bool = false, viewConfiguration: ((_ inputAlertView: SHInputAlertView) -> Void)?, cancelAction: (() -> Void)?, confirmAction: @escaping ((_ inputAlertView: SHInputAlertView) -> Void)) {
        let inputAlertView: SHInputAlertView = SHInputAlertView()
        inputAlertView.textField.placeholder = placeholder
        viewConfiguration?(inputAlertView)
        inputAlertView.confirmActionWithView = confirmAction
        inputAlertView.addView(title: title, customView: inputAlertView.contentView, inViewController: inViewController, cancelAction: cancelAction, confirmAction: {})
    }
    
}
