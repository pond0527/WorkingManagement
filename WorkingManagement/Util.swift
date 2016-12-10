//
//  Utils.swift
//  WorkingManagement
//
//  Created by Tetsu on 2016/11/10.
//  Copyright © 2016年 Pond_T. All rights reserved.
//

import UIKit
import Foundation


/// 便利な機能を提供します。
public class Util {
    private static let alertView = SweetAlert()
    
    
    /// アラートを表示します。
    ///
    /// - Parameters:
    ///   - title: <#title description#>
    ///   - subTitle: <#subTitle description#>
    ///   - btnTitle: <#btnTitle description#>
    public static func showAlert(title: String = "", subTitle: String = "", btnTitle: String = "") {
        _ = alertView.showAlert(title, subTitle: subTitle, style: .none, buttonTitle: btnTitle)
    }
    
    public static func eq(target: String?, str: String?) -> Bool {
        guard let _ = target else { return false }
        guard let _ = str else { return false }
        
        return target! == str!
    }
    
    
    public static func eqAny(target: String?, args: String...) -> Bool {
        guard let _ = target else { return false }
        
        for arg in args {
            if eq(target: target, str: arg) {
                return true
            }
        }
        return false
    }
    
    
    /// 指定した日付を、YYYY/MMの書式で返却します。
    ///
    /// - Parameter date: 日付
    /// - Returns: 整形後文字列
    public static func formatDateToString(date: Date) -> String {
        return "\(date.year)/\(date.month)"
    }
    

}
