//
//  FirstViewController.swift
//  WorkingManagement
//
//  Created by Tetsu on 2016/10/18.
//  Copyright © 2016年 Pond_T. All rights reserved.
//

import UIKit
import ChameleonFramework
import SwiftDate
import SnapKit
import FoldingTabBar

class CalendarView: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var calendarView: UICollectionView!
    let dataManager = DataManager.getInstance()
    var shortWeekdaySymbols: [String] = []
    var fromWeekendIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        setupNaviBar()
        setupCalendarView()
        shortWeekdaySymbols = dataManager.getShortWeekdaySymbols()
        fromWeekendIndex = dataManager.fromWeekendIndex()
        self.navigationItem.title = Util.formatDateToString(date: dataManager.date)
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
        
        let flowLayout = setupGrid(numberOfGridsPerRow: dataManager.getShortWeekdaySymbols().count,
                                            gridLineSpace: CalendarConfig.GRID_LINE_SPACE,
                                            sectionInset: inset)
        
        calendarView = UICollectionView(frame: self.view.frame, collectionViewLayout: flowLayout)
        calendarView.backgroundColor = CalendarColor.view.value
        
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
        dataManager.setNextMonth()
        self.loadView()
        self.viewDidLoad()
    }
    
    /// 前月: ナビゲーション押下時イベントの設定を行う。
    func tapPreviousMonth() {
        dataManager.setPreviousMonth()
        self.loadView()
        self.viewDidLoad()
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
            return dataManager.getShortWeekdaySymbols().count
        } else {
            return dataManager.lastOfDay + dataManager.fromWeekendIndex()
        }
    }

    
    // =========================================================================
    // MARK: - UICollectionViewDataSource
    
    
    /// 指定したセルに値を設定する。
    ///
    /// - parameter collectionView: <#collectionView description#>
    /// - parameter indexPath:      <#indexPath description#>
    ///
    /// - returns: <#return value description#>
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calendarCell", for: indexPath as IndexPath) as! CalendarCellView
        
        if indexPath.section == CalendarConfig.SECTION_WEEK {
            cell.backgroundColor = CalendarColor.holiday.value
            cell.dateLabel.text = shortWeekdaySymbols[indexPath.row]
        } else {
            if fromWeekendIndex <= indexPath.row {
                cell.backgroundColor = CalendarColor.workday.value
                let dateIndex: Int = indexPath.row - fromWeekendIndex
                cell.dateLabel.text = String(dataManager.getIndexDateForCell(index: dateIndex))
            }
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
    private func setupGrid(numberOfGridsPerRow: Int, gridLineSpace space: CGFloat, sectionInset inset: UIEdgeInsets) -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        guard numberOfGridsPerRow > 0 else { return layout }

        var length = self.view.frame.width
        length -= space * CGFloat(numberOfGridsPerRow - 1)
        length -= (inset.left + inset.right)
        
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

