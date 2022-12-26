//
//  SHCalendar.swift
//  Saiha
//
//  Created by 河瀬雫 on 2022/11/15.
//

import Foundation

public struct SHCalendar {
    
    public static var current: SHCalendar = SHCalendar()
    
    private var calendar: Calendar = Calendar.current
    
    public init() {
        self.calendar = Calendar.current
    }
    
    public init(calendar: Calendar) {
        self.calendar = calendar
    }
    
    public func day(date: SHDate) -> Int {
        var dateComponents: DateComponents = DateComponents.init()
        dateComponents = self.calendar.dateComponents([.day], from: date.toDate())
        return dateComponents.day!
    }
    
    public func month(date: SHDate) -> Int {
        var dateComponents: DateComponents = DateComponents.init()
        dateComponents = self.calendar.dateComponents([.month], from: date.toDate())
        return dateComponents.month!
    }
    
    // Week 的范围是 1~7，其中 1 代表星期天，2 代表星期一。
    public func week(date: SHDate) -> Int {
        var dateComponents: DateComponents = DateComponents.init()
        dateComponents = self.calendar.dateComponents([.weekday], from: date.toDate())
        return dateComponents.weekday!
    }
    
    public func date(byAdding: Calendar.Component, value: Int, to: SHDate) -> SHDate {
        let date: Date = self.calendar.date(byAdding: byAdding, value: value, to: to.toDate())!
        return SHDate.init(date: date)
    }
}

extension SHCalendar {
    
    // MARK: - 获取给定时间的月份的第一天。
    
    public func getFirstDateOfMonth(date: SHDate) -> SHDate {
        let dateComponents: DateComponents = self.calendar.dateComponents([.year, .month], from: date.toDate())
        let firstDateOfMonth: SHDate = SHDate(date: self.calendar.date(from: dateComponents)!)
        return firstDateOfMonth
    }
    
    // MARK: - 获取给定时间月份的最后一天。
    
    public func getLastDateOfMonth(date: SHDate) -> SHDate {
        var dateComponents: DateComponents = DateComponents.init()
        dateComponents.month = 1
        dateComponents.second = -1
        let lastDateOfMonth: SHDate = SHDate(date: self.calendar.date(byAdding: dateComponents, to: self.getFirstDateOfMonth(date: date).toDate())!)
        return lastDateOfMonth
    }
}
