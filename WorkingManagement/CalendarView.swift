//
//  FirstViewController.swift
//  WorkingManagement
//
//  Created by 池田哲 on 2016/10/18.
//  Copyright © 2016年 池田哲. All rights reserved.
//

import UIKit
import ChameleonFramework
import SwiftDate
import SnapKit

class CalendarView: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var calendarView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupNaviBar()
        setupCalendarView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // =========================================================================
    // MARK: - Create View
    
    
    /// ナビゲーションヘッダの生成を行う。
    private func setupNaviBar() {
        self.navigationItem.title = "勤怠表"
        
        let nextMonth = UIBarButtonItem(title: "次月", style: .plain, target: self, action: #selector(CalendarView.tapNextMonth))
        let nextMonthTagNum = 0
        nextMonth.tag = nextMonthTagNum
        self.navigationItem.rightBarButtonItem = nextMonth
        
        let previousMonth = UIBarButtonItem(title: "前月", style: .done, target: self, action: #selector(CalendarView.tapPreviousMonth))
        let previousMonthTagNum = 1
        previousMonth.tag = previousMonthTagNum
        self.navigationItem.leftBarButtonItem = previousMonth
    }
    
    /// カレンダー画面の生成を行う。
    private func setupCalendarView() {
        let inset = UIEdgeInsets(top: CalendarConfig.GRID_LINE_SPACE,
                                 left: CalendarConfig.GRID_LINE_SPACE,
                                 bottom: CalendarConfig.GRID_LINE_SPACE,
                                 right: CalendarConfig.GRID_LINE_SPACE)
        
        let flowLayout = setupBeautifulGrid(numberOfGridsPerRow: CalendarConfig.MAX_WEEKEND,
                                            gridLineSpace: CalendarConfig.GRID_LINE_SPACE,
                                            sectionInset: inset)
        
        calendarView = UICollectionView(frame: self.view.frame, collectionViewLayout: flowLayout)
        calendarView.backgroundColor = CalendarColor.view.get
        
        let calendarCell: UINib = UINib(nibName: "CalendarCellView", bundle: nil)
        calendarView.register(calendarCell, forCellWithReuseIdentifier: "calendarCell")
        
        calendarView.delegate = self
        calendarView.dataSource = self
        
        self.view.addSubview(calendarView)
        
        // 制約
        calendarView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(100).offset(100)
            make.size.equalTo(CGSize(width: self.view.bounds.width, height: self.view.bounds.height - 250))
        }
    }
    
    // =========================================================================
    // MARK: - NavigationController Event
    
    
    /// 次月: ナビゲーション押下時イベントの設定を行う。
    func tapNextMonth() {
        _ = SweetAlert().showAlert("仮実装", subTitle: "長押し検出: 次月", style: .none, buttonTitle: "OK")
    }
    
    /// 前月: ナビゲーション押下時イベントの設定を行う。
    func tapPreviousMonth() {
        _ = SweetAlert().showAlert("仮実装", subTitle: "長押し検出: 前月", style: .none, buttonTitle: "OK")
    }
    
    // =========================================================================
    // MARK: - UICollectionViewDataSource
    
    
    /// セクション数の設定を行う。
    ///
    /// - Parameter collectionView: <#collectionView description#>
    /// - Returns: <#return value description#>
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return CalendarConfig.MAX_SECTION_NUM
    }
    
    /// 指定したセクションにセル数の設定を行う。
    ///
    /// - Parameters:
    ///   - collectionView: <#collectionView description#>
    ///   - section: <#section description#>
    /// - Returns: <#return value description#>
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == CalendarConfig.SECTION_WEEK {
            return CalendarConfig.MAX_WEEKEND
        } else {
            return CalendarConfig.TEST_MAX_DATE
        }
    }

    // =========================================================================
    // MARK: - UICollectionViewDataSource
    
    
    var cnt = 1
    /// 指定したセルに値を設定する。
    ///
    /// - parameter collectionView: <#collectionView description#>
    /// - parameter indexPath:      <#indexPath description#>
    ///
    /// - returns: <#return value description#>
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calendarCell", for: indexPath as IndexPath) as! CalendarCellView
        
        if indexPath.section == CalendarConfig.SECTION_WEEK {
            cell.backgroundColor = CalendarColor.holiday.get
            cell.dateLabel.text = WeekDay.weekdays[indexPath.row].name
        } else {
//            cell.backgroundColor = CalendarColor.date.get
            cell.dateLabel.text = String(cnt)
            cnt += 1
        }
        return cell
    }

    // =========================================================================
    // MARK: - UICollectionViewDelegateFlowLayout
    
    
    /// UICollectionViewレイアウトの設定を行う。
    ///
    /// - Parameters:
    ///   - numberOfGridsPerRow: １行に表示するセルの数
    ///   - space: セル間隔
    ///   - inset: 位置調整
    /// - Returns: FlowLayout
    private func setupBeautifulGrid(numberOfGridsPerRow: Int, gridLineSpace space: CGFloat, sectionInset inset: UIEdgeInsets) -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        guard numberOfGridsPerRow > 0 else { return layout }
        

        var length = self.view.frame.width
        length -= space * CGFloat(numberOfGridsPerRow - 1)
        
        let isScrollDirectionVertical = layout.scrollDirection == .vertical
        length -= isScrollDirectionVertical ? (inset.left + inset.right) : (inset.top + inset.bottom)
        
        let side = length / CGFloat(numberOfGridsPerRow)
        guard side > 0.0 else { return layout }
        
        layout.itemSize = CGSize(width: side, height: side)
        layout.minimumLineSpacing = space
        layout.minimumInteritemSpacing = space
        layout.sectionInset = inset
        layout.invalidateLayout()
        
        return layout
    }

}

