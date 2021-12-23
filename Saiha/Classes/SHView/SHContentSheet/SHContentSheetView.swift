//
//  SHContentSheetView.swift
//  Saiha
//
//  Created by 河瀬雫 on 2021/11/10.
//

import UIKit

// MARK: - SHContentSheetView.

open class SHContentSheetView: SHUIView {
    
    public static var sharedView: SHContentSheetView?

    private var backgroundView: UIView!
    private var sepratorLine: UIView!
    private var cancelButton: UIButton!
    private var mainView: UIView!
    
    open var contentHeight: CGFloat = 0
    
    open var completionHandler: (() -> Void)?
            
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        self.backgroundView = UIView()
        self.backgroundView.backgroundColor = UIColor.saiha_colorWithHexString("#000000", alpha: 0.7)
        self.addSubview(self.backgroundView)
        self.backgroundView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
        
        self.cancelButton = SHUIButton()
        self.cancelButton.backgroundColor = .white
        self.cancelButton.setTitle("取消", for: .normal)
        self.cancelButton.setTitleColor(.black, for: .normal)
        self.cancelButton.titleLabel?.bounds = self.cancelButton.bounds
        self.cancelButton.titleLabel?.textAlignment = .center
        self.cancelButton.titleLabel?.font = .systemFont(ofSize: CGFloat.saiha_verticalSize(num: 17))
        self.cancelButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: UIWindow.saiha_safeAreaInsets().bottom, right: 0)
        self.cancelButton.layer.backgroundColor = UIColor.white.cgColor
        self.cancelButton.addTarget(self, action: #selector(self.touchCancelAction(sender:)), for: .touchUpInside)
        self.backgroundView.addSubview(self.cancelButton)
        self.cancelButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            //make.bottomMargin.equalToSuperview()
            make.bottom.equalTo(self.snp.bottom)
            //make.top.lessThanOrEqualTo(self.snp.bottom).offset(CGFloat.saiha.verticalSize(num: -56))
            make.height.equalTo(CGFloat.saiha_verticalSize(num: 56) + UIWindow.saiha_safeAreaInsets().bottom)
        }
        
        self.sepratorLine = UIView()
        self.sepratorLine.backgroundColor = UIColor.saiha_colorWithHexString("#F2F2F2")
        self.backgroundView.addSubview(self.sepratorLine)
        self.sepratorLine.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.cancelButton.snp.top)
            make.height.equalTo(CGFloat.saiha_verticalSize(num: 8))
        }
        
        self.mainView = UIView()
        self.mainView.backgroundColor = .white
        self.backgroundView.addSubview(self.mainView)
        self.mainView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.sepratorLine.snp.top).offset(0)
            make.height.equalTo(self.contentHeight)
        }
        
        self.mainView.clipsToBounds = true
    }
    
    public static func show(customView: UIView, contentHeight: CGFloat, completionHandler: ((() -> Void)?)) {
        if Self.sharedView != nil {
            return
        }
        let sheetView: SHContentSheetView = SHContentSheetView()
        sheetView.completionHandler = completionHandler
        sheetView.mainView.addSubview(customView)
        customView.snp.makeConstraints { make in
            make.left.top.right.bottom.equalToSuperview()
        }
        sheetView.contentHeight = contentHeight
        UIWindow.saiha_securyWindow()?.addSubview(sheetView)
        sheetView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
        sheetView.layer.cornerRadius = 10
        sheetView.mainView.layer.cornerRadius = 10
        if #available(iOS 11.0, *) {
            //sheetView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            sheetView.mainView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        } else {
            sheetView.layoutIfNeeded()
        }
        Self.sharedView = sheetView
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        self.mainView.snp.updateConstraints { make in
            make.height.equalTo(self.contentHeight)
        }
        
        if #available(iOS 11.0, *) {
            
        } else {
            //self.mainView.roundedCornerRadius(self.mainView.bounds, corner: [.topLeft, .topRight], cornerRadii: CGSize(width: 10, height: 10))
        }
    }
    
    @objc func touchCancelAction(sender: UIButton) {
        self.isHidden = true
        self.removeFromSuperview()
        self.completionHandler?()
    }
    
    public static func dismiss() {
        Self.sharedView?.isHidden = true
        Self.sharedView?.removeFromSuperview()
        Self.sharedView = nil
    }
}
