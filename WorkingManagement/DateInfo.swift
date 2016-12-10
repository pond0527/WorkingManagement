//
//  DateInfo.swift
//  WorkingManagement
//
//  Created by Tetsu on 2016/11/23.
//  Copyright © 2016年 池田哲. All rights reserved.
//

import Foundation

class DateInfo {
    
    /// 日付
    public var day: String = ""
    
    /// 曜日
    public var weekday: WeekDay = WeekDay.none
    
    /// 曜日セル判定(true: 曜日セル、 false: 日付セル)
    public var isWeekdayCell: Bool = false
    
    /// 休日かどうか(true: 休日、 false: 平日)
    public var isHoliday: Bool {        
        switch weekday {
        case WeekDay.sunday, WeekDay.saturday:
            return true
        default:
            return false
        }
    }
    
}
