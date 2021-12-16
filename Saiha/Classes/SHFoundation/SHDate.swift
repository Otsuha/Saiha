//
//  SHDate.swift
//  Saiha
//
//  Created by 河瀬雫 on 2021/12/16.
//

import Foundation

extension Date {
    
    var saiha: SaihaDate {
        return SaihaDate(date: self)
    }
    
    static var saiha: SaihaDate {
        return SaihaDate(date: Date())
    }
}

public struct SaihaDate {
    
    private var date: Date
    
    init(date: Date) {
        self.date = date
    }
    
    /**
     获取接收者的秒级时间戳。
     */
    public func timeStamp() -> String {
        let timeInterval: TimeInterval = self.date.timeIntervalSince1970
        return "\(timeInterval)"
    }
    
    /**
     获取接收者的毫秒级时间戳。
     */
    public func milliTimeStamp() -> String {
        let timeInterval: TimeInterval = self.date.timeIntervalSince1970
        let millisecond = CLongLong(round(timeInterval * 1000))
        return "\(millisecond)"
    }
    
}

extension SaihaDate {
    
    public enum SHDateFormatter: String {
        case ym = "yyyy-MM"
        case ymd = "yyyy-MM-dd"
        case ymdHm = "yyyy-MM-dd HH:mm"
        case ymdHms = "yyyy-MM-dd HH:mm:ss"
        case md = "MM-dd"
        case dm = "dd-MM"
    }
    
    /**
     时间戳转日期字符串。返回的是毫秒级别的时间戳。
     */
    public func timeStampToDateString(timeStamp: Double, formatter: SaihaDate.SHDateFormatter) -> String {
        let timesta: TimeInterval = timeStamp / 1000
        let aDateFormatter: DateFormatter = DateFormatter()
        aDateFormatter.dateFormat = formatter.rawValue
        let date: Date = Date(timeIntervalSince1970: timesta)
        return aDateFormatter.string(from: date)
    }
}
