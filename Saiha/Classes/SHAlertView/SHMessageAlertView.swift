//
//  SHMessageAlertView.swift
//  Saiha
//
//  Created by 御前崎悠羽 on 2022/3/14.
//

import Foundation

open class SHMessageAlertView: SHUIView {
    
    open var label: SHUILabel = {
        let label: SHUILabel = SHUILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: CGFloat.saiha_verticalSize(num: 19))
        return label
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.label)
        self.label.snp.makeConstraints { make in
            make.left.top.right.bottom.equalToSuperview()
            make.height.greaterThanOrEqualTo(CGFloat.saiha_verticalSize(num: 85))
        }
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public static func show(title: String?, message: String, inViewController: Bool = false, cancelAction: (() -> Void)?, confirmAction: @escaping (() -> Void)) {
        let messageAlertView: SHMessageAlertView = SHMessageAlertView()
        messageAlertView.label.text = message
        SHAlertView.show(title: title, customView: messageAlertView, inViewController: inViewController, viewConfiguration: nil, cancelAction: cancelAction, confirmAction: confirmAction)
    }
}
