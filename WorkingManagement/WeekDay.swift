//
//  WeekDay.swift
//  WorkingManagement
//
//  Created by Tetsu on 2016/11/09.
//  Copyright © 2016年 Pond_T. All rights reserved.
//

import Foundation

/// 週の定義を行う。
public enum WeekDay {
    case sunday, monthday, tuesday, wednesday, thursday, friday, saturday, none
    public static let weekdays:[WeekDay] = [WeekDay.sunday,
                                     WeekDay.monthday,
                                     WeekDay.tuesday,
                                     WeekDay.wednesday,
                                     WeekDay.thursday,
                                     WeekDay.friday,
                                     WeekDay.saturday,
                                     WeekDay.none]

    
    /// 名称を取得します。
    var name: String {
        switch self {
        case .sunday:
            return "日"
        case .monthday:
            return "月"
        case .tuesday:
            return "火"
        case .wednesday:
            return "水"
        case .thursday:
            return "木"
        case .friday:
            return "金"
        case .saturday:
            return "土"
        case .none:
            return ""
        }
    }
}
