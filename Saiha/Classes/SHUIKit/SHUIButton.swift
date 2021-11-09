//
//  SHUIButton.swift
//  Saiha
//
//  Created by 御前崎悠羽 on 2021/11/9.
//

import UIKit

open class SHUIButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentHorizontalAlignment = .fill
        self.contentVerticalAlignment = .fill
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
