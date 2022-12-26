//
//  SHCalendarViewDelegate.swift
//  Saiha
//
//  Created by Grass Plainson on 2021/3/8.
//

import Foundation
import UIKit
import Saiha

@objc public protocol SHCalendarViewDelegate {
    
    @objc optional func calendarView(itemSizeForCalendarView: SHCalendarView) -> CGSize
    
    @objc optional func calendarView(
        calendarView: SHCalendarView,
        didSelectCell cell: SHCalendarDateButton
    )
    
    @objc optional func calendarView(
        calendarView: SHCalendarView,
        didDeSelectCell cell: SHCalendarDateButton
    )
    
    @objc optional func calendarView(
        calendarView: SHCalendarView,
        cellItemSize: CGSize,
        viewForCellAt date: SHDate?
    ) -> SHUIView?
    
    @objc optional func calendarView(
        enableSelectDateIn calendarView: SHCalendarView,
        date: SHDate,
        cell: SHCalendarDateButton
    ) -> Bool
}
