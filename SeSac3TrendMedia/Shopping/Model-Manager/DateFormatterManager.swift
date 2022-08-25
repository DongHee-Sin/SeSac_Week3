//
//  DateFormatterManager.swift
//  SeSac3TrendMedia
//
//  Created by 신동희 on 2022/08/25.
//

import Foundation


struct DateFormatterManager {
    
    private let formatter = DateFormatter()
    
    var currentDateString: String {
        return formatter.string(from: Date())
    }
    
    
    init() {
        setDateFormatter()
    }
    
    private func setDateFormatter() {
        formatter.dateFormat = "_yyMMdd_hh:mm:ss"
    }
    
}
