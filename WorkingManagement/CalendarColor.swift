//
//  CalendarColor.swift
//  WorkingManagement
//
//  Created by Tetsu on 2016/11/09.
//  Copyright © 2016年 池田哲. All rights reserved.
//

import UIKit
import ChameleonFramework

/// カレンダー画面で使用する色の設定を行う。
public enum CalendarColor {
    case view, workday, holiday, date
    
    var get: UIColor {
        switch self {
        case .view:
            return UIColor.white
        case .workday:
            return UIColor.flatWhite()
        case .holiday:
            return UIColor.flatPink()
        case .date:
            return UIColor.flatLime()
        }
    }
}
