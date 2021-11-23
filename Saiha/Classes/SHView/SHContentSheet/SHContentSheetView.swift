//
//  SHContentSheetView.swift
//  Saiha
//
//  Created by 河瀬雫 on 2021/11/10.
//

import UIKit

// MARK: - SHContentSheetView.

open class SHContentSheetView: SHUIView {

    private var backgroundView: UIView!
    private var sepratorLine: UIView!
    private var cancelButton: UIButton!
    private var mainView: UIView!
    
    open var contentHeight: CGFloat = 0
    
    open var completionHandler: (() -> Void)?
    
    public static var normalWidgeHeight: CGFloat {
        return CGFloat.saiha.verticalSize(num: 56) + UIWindow.saiha.safeAreaInsets().bottom + CGFloat.saiha.verticalSize(num: 8)
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundView = UIView()
        self.backgroundView.backgroundColor = UIColor.saiha.colorWithHexString("#000000", alpha: 0.7)
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
        self.cancelButton.titleLabel?.font = .systemFont(ofSize: CGFloat.saiha.verticalSize(num: 17))
        self.cancelButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: UIWindow.saiha.safeAreaInsets().bottom, right: 0)
        self.cancelButton.layer.backgroundColor = UIColor.white.cgColor
        self.cancelButton.addTarget(self, action: #selector(self.touchCancelAction(sender:)), for: .touchUpInside)
        self.backgroundView.addSubview(self.cancelButton)
        self.cancelButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            //make.bottomMargin.equalToSuperview()
            make.bottom.equalTo(self.snp.bottom)
            //make.top.lessThanOrEqualTo(self.snp.bottom).offset(CGFloat.saiha.verticalSize(num: -56))
            make.height.equalTo(CGFloat.saiha.verticalSize(num: 56) + UIWindow.saiha.safeAreaInsets().bottom)
        }
        
        self.sepratorLine = UIView()
        self.sepratorLine.backgroundColor = UIColor.saiha.colorWithHexString("#F2F2F2")
        self.backgroundView.addSubview(self.sepratorLine)
        self.sepratorLine.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.cancelButton.snp.top)
            make.height.equalTo(CGFloat.saiha.verticalSize(num: 8))
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
        let sheetView: SHContentSheetView = SHContentSheetView()
        sheetView.completionHandler = completionHandler
        sheetView.mainView.addSubview(customView)
        customView.snp.makeConstraints { make in
            make.left.top.right.bottom.equalToSuperview()
        }
        sheetView.contentHeight = contentHeight
        UIWindow.saiha.securyWindow()?.addSubview(sheetView)
        sheetView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
        sheetView.saiha.addRoundedCorners(cornerPositons: [.topLeft, .topRight], radius: 10)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        self.mainView.snp.updateConstraints { make in
            make.height.equalTo(self.contentHeight)
        }
    }
    
    @objc func touchCancelAction(sender: UIButton) {
        self.isHidden = true
        self.removeFromSuperview()
        self.completionHandler?()
    }
}
