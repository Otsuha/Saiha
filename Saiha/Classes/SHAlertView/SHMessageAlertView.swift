//
//  SHMessageAlertView.swift
//  Saiha
//
//  Created by 御前崎悠羽 on 2022/3/14.
//

import Foundation

open class SHMessageAlertView: SHAlertView {
    
    private var label: SHUILabel = {
        let label: SHUILabel = SHUILabel()
        label.numberOfLines = 0
        return label
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.label)
        self.label.snp.makeConstraints { make in
            make.left.top.right.bottom.equalToSuperview()
        }
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public static func show(title: String?, message: String, inViewController: Bool = false, viewConfiguration: ((_ label: SHUILabel) -> Void)?, cancelAction: ((_ button: SHUIButton) -> Void)?, confirmAction: @escaping ((_ button: SHUIButton) -> Void)) {
        let messageAlertView: SHMessageAlertView = SHMessageAlertView()
        messageAlertView.label.text = message
        viewConfiguration?(messageAlertView.label)
        SHAlertView.show(title: title, customView: messageAlertView, inViewController: inViewController, cancelAction: cancelAction, confirmAction: confirmAction)
    }
}
