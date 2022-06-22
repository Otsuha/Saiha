//
//  SHSingleButtonAlertView.swift
//  Saiha
//
//  Created by 御前崎悠羽 on 2022/6/22.
//

import Foundation

open class SHSingleButtonAlertView: SHAlertView {
    
    override func setUI() {
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
        let firstButton: SHUIButton = self.confirmButton
        self.mainContentView.addSubview(firstButton)
        firstButton.snp.remakeConstraints { make in
            if lastView != nil {
                make.top.equalTo(lastView!.snp.bottom).offset(CGFloat.saiha_verticalSize(num: self.viewEdge))
            } else {
                make.top.equalToSuperview().offset(CGFloat.saiha_verticalSize(num: self.viewEdge))
            }
            make.height.equalTo(CGFloat.saiha_verticalSize(num: 58))
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(CGFloat.saiha_verticalSize(num: 0))
        }
        firstButton.saiha_addSeparator(color: self.separatorColor, position: .top, leftEdge: self.separatorEdge, rightEdge: 0)
    }
    
    deinit {
        saiha_print("弹框消失")
    }
}
