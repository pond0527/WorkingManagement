//
//  CalendarConfig.swift
//  WorkingManagement
//
//  Created by Tetsu on 2016/11/08.
//  Copyright © 2016年 Pond_T. All rights reserved.
//

import Foundation
import UIKit
import ChameleonFramework

/// カレンダー定数を定義します。
public class CalendarConfig {
    
    /// セクション数
    public static let MAX_SECTION_NUM = 2
    
    /// 曜日のセクション番号
    public static let SECTION_WEEK = 0
    
    /// 日付のセクション番号
    public static let SECTION_DATE = 1
    
    /// セル間隔
    public static let GRID_LINE_SPACE: CGFloat = 1.0
    
    /// 日本語圏
    public static let JA_LOCALE = "ja_JP"
}
