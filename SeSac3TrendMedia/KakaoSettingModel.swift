//
//  KakaoSettingModel.swift
//  SeSac3TrendMedia
//
//  Created by 신동희 on 2022/07/18.
//

import Foundation

struct SettingSectionData {
    var sectionTitle: String
    var sectionCell: [String]
}


struct KakaoSettingDataManager {
    
    private var settingList: [SettingSectionData] = []
    
    
    init() {
        settingList = [
            SettingSectionData(sectionTitle: "전체 설정", sectionCell: ["공지사항", "실험실", "버전 정보"]),
            SettingSectionData(sectionTitle: "개인 설정", sectionCell: ["개인/보안", "알림", "채팅", "멀티프로필"]),
            SettingSectionData(sectionTitle: "기타", sectionCell: ["고객센터/도움말"])
        ]
    }
    
    
    func getSectionTitle(at index: Int) -> String {
        return settingList[index].sectionTitle
    }
    
    
    func getSectionCount() -> Int {
        return settingList.count
    }
    
    
    func getSectionCellTitle(sectionIndex: Int, cellIndex: Int) -> String {
        return settingList[sectionIndex].sectionCell[cellIndex]
    }
    
    
    func getSectionCellCount(at index: Int) -> Int {
        return settingList[index].sectionCell.count
    }
    
    
    mutating func addSettingSection(sectionTitle: String, sectionCell: [String]) {
        let new = SettingSectionData(sectionTitle: sectionTitle, sectionCell: sectionCell)
        
        settingList.append(new)
    }
}
