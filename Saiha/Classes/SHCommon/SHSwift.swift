//
//  SHSwift.swift
//  Saiha
//
//  Created by 御前崎悠羽 on 2022/1/27.
//

import Foundation

public func saiha_print(_ items: Any..., file: String = #file, method: String = #function, line: Int = #line) {
    print("file: \(file), method: \(method), line: \(line)")
    for item in items {
        print(item)
    }
}
