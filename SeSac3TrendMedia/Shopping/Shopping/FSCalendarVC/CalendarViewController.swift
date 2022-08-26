//
//  CalendarViewController.swift
//  SeSac3TrendMedia
//
//  Created by 신동희 on 2022/08/27.
//

import UIKit
import FSCalendar


class CalendarViewController: UIViewController {

    @IBOutlet weak var calendarView: FSCalendar!
    
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy. MM. dd."
        return formatter
    }()
    
    var handler: ((String) -> Void)?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendarView.delegate = self
        calendarView.dataSource = self
    }
    
}



extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        handler?(formatter.string(from: date))
    }
    
}
