//
//  DataManager.swift
//  WorkingManagement
//
//  Created by Tetsu on 2016/11/09.
//  Copyright © 2016年 Pond_T. All rights reserved.
//

import Foundation
import SwiftDate


// ==============================================================================
// MARK: Extesitions


//　Locate を拡張
// 日本語圏に設定
extension Locale {
    static var current: Locale {
        return Locale(identifier: "ja_JP")
    }
}


// ==============================================================================
// MARK: Structure


struct CalendarInfo {
    /// 年
    var year: Int
    
    /// 月
    var month: Int
    
    /// 日
    var day: Int
    
    
    ///  デフォルト: 現在日付
    init(year: Int = Date().year, month: Int = Date().month, day: Int = Date().day) {
        self.year = year
        self.month = month
        self.day = day
    }
}


/// 暦に関するユーティリティメソッドを提供します。
final class DataManager {
    
    // ==============================================================================
    // MARK: Constract
    
    
    private static let _dataManager: DataManager = DataManager()
    private static var _calendar: CalendarInfo = CalendarInfo()
    
    /// Do Nothing
    private init() {}
    
    /// 指定した暦のインスタンスを取得します。
    ///
    /// - Returns: 暦の情報
    public static func getInstance() -> DataManager {
        setDateOfMonth()
        return _dataManager
    }
    
    
    // ==============================================================================
    // MARK: Property Definition
    
    
    private var cal: Calendar {
        get {
            var _cal = Calendar.current
            _cal.locale = Locale.current
            return _cal
        }
    }
    
    
    /// 指定した年/月/日のDate型を返却します。
    public var date: Date {
        let components = createDateComponents(ctypes: DataManager._calendar.year,
                                              DataManager._calendar.month,
                                              DataManager._calendar.day,
                                              00,
                                              00)
        
        let toDate = cal.date(from: components)
        let jaToDate = toDate?.description(with: cal.locale)
        
        print("date: \(jaToDate))")
        return toDate!
    }
    
    /// 休日かどうか(true: 休日、 false: 平日)
    public var isHoliday: Bool {
        return Util.eqAny(target: self.date.weekdayName,
                          args: WeekDay.saturday.name,
                                WeekDay.sunday.name)
    }
    
    /// 表示する月の日付を格納します。
    private var _dateOfMonth :[Int] = []
    
    /// 現在日付を返却します。
    public var currentDate: Date = Date().inLocalRegion().absoluteDate {
        willSet {
            for day in 1...DataManager._dataManager.lastOfDay {
                _dateOfMonth.append(day)
            }
        }
    }
    
    /// 月の末日を返却します。
    public var lastOfDay: Int {
        get {
            let nextMonth = date.nextMonth
            let compornent = createDateComponents(ctypes: nextMonth.year,
                                                  nextMonth.month,
                                                  1,
                                                  00,
                                                  00)
            
            // 次月の初日から１日減算して、末日を取得
            return (cal.date(from: compornent)! - 1.day).day
        }
    }
    
    /// 月の初日を返却します。
    public var startOfDay: Int {
        return self.date.startOfDay.day
    }
    
    /// 曜日の名称を取得します。
    /// 注: 英語で取得される
    public var weekdayName: String {
        return self.date.weekdayName
    }
    
    
    // ==============================================================================
    // MARK: Method
    
    
    /// 対象月の日付を格納します。
    private static func setDateOfMonth() {        
        for day in 1...DataManager._dataManager.lastOfDay {
            DataManager._dataManager._dateOfMonth.append(day)
        }
    }
    
    /// 指定したパスに該当する日付を返却します。
    ///
    /// - Parameter index: <#index description#>
    /// - Returns: <#return value description#>
    public func getIndexDateForCell(index: Int) -> Int {
        return self._dateOfMonth[index]
    }
    
    /// 曜日セル判定(true: 曜日セル、 false: 日付セル)
    public func isWeekdayCell(indexPath: IndexPath) -> Bool {
        return indexPath.section == CalendarConfig.SECTION_WEEK
    }
    
    
    /// カレンダーを指定した年月日で設定します。
    ///
    /// - Parameters:
    ///   - year: 年
    ///   - month: 月
    ///   - day: 日
    public func setCalendar(year: Int = Date().year,
                            month: Int = Date().month,
                            day: Int = Date().day) {
        DataManager._calendar = CalendarInfo(year: year, month: month, day: day)
    }
    
    /// 年,月,日,時,分を持つ DateComponentsを生成します。
    private func createDateComponents(ctypes : Int...) -> DateComponents{
        var components = DateComponents()
        for (idx, ctype) in ctypes.enumerated() {
            switch idx {
            case 0: components.year = ctype
            case 1: components.month = ctype
            case 2: components.day = ctype
            case 3: components.hour = ctype
            case 4: components.minute = ctype
            default: break
            }
        }
        return components
    }
    
    /// 週の定義を返却します。
    ///
    /// - Returns: 日、月、火・・・
    public func getShortWeekdaySymbols() -> [String] {
        return cal.shortWeekdaySymbols
    }
    
    
    /// 曜日の番号(Index)を取得します。
    ///
    /// - Parameter element: 曜日
    /// - Returns: 差
    public func fromWeekendIndex() -> Int {
        let components = createDateComponents(ctypes: DataManager._calendar.year,
                                              DataManager._calendar.month,
                                              1, // 月の初日を基準
                                              00,
                                              00)
        
        let currrentIndex = cal.component(.weekday, from: cal.date(from: components)!)
        return currrentIndex - 1
    }
    
    /// 次月を設定します。
    public func setNextMonth() {
        self.setCalendar(year: DataManager._calendar.year,
                         month: DataManager._calendar.month + 1,
                         day: 1)
    }
    
    /// 前月を設定します。
    public func setPreviousMonth() {
        self.setCalendar(year: DataManager._calendar.year,
                         month: DataManager._calendar.month - 1,
                         day: 1)
    }
    
}
