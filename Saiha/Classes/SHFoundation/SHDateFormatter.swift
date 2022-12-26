//
//  SHDateFormatter.swift
//  Saiha
//
//  Created by 河瀬雫 on 2022/11/15.
//

import Foundation

public class SHDateFormatter: DateFormatter {
    
    override public init() {
        super.init()
        
        self.locale = Locale.init(identifier: "zh_Hans_CN")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
