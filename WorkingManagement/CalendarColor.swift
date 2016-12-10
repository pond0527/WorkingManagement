//
//  CalendarColor.swift
//  WorkingManagement
//
//  Created by Tetsu on 2016/11/09.
//  Copyright © 2016年 Pond_T. All rights reserved.
//

import UIKit
import ChameleonFramework

/// カレンダー画面で使用する色の設定を行う。
public enum CalendarColor {
    case view, workday, holiday
    
    var value: UIColor {
        switch self {
        case .view:
            return UIColor.white
        case .workday:
            return UIColor.flatWhite()
        case .holiday:
            return UIColor.flatPink()
        }
    }
}
