//
//  SHBundle.swift
//  Saiha
//
//  Created by 河瀬雫 on 2022/1/10.
//

import Foundation

public extension Bundle {
    
    static func resource(forName name: String) -> Bundle? {
        guard let bundle = Bundle.main.url(forResource: name, withExtension: "bundle") else {
            return nil
        }
        let currentBundle = Bundle(url: bundle)
        return currentBundle
    }
}
