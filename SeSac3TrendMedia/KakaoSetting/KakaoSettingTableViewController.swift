//
//  Case2SettingTableViewController.swift
//  SeSac3TrendMedia
//
//  Created by 신동희 on 2022/07/18.
//

import UIKit

class KakaoSettingTableViewController: UITableViewController {

    // MARK: - Propertys
    
    let settingDataManager = KakaoSettingDataManager()
    
    
    
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    // MARK: - Table view data source

    // 섹션의 개수
    override func numberOfSections(in tableView: UITableView) -> Int {
        //return settingDataManager.getSectionCount()
        
        // ☘️ 열거형을 사용한 개선
        return SettingOption.allCases.count
    }

    // 섹션별 셀의 개수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return settingDataManager.getSectionCellCount(at: section)
        
        // ☘️ 열거형을 사용한 개선
        return SettingOption.allCases[section].rowTitle.count
    }

    // 사용할 Cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell") else {
            return UITableViewCell()
        }

        //cell.textLabel?.text = settingDataManager.getSectionCellTitle(sectionIndex: indexPath.section, cellIndex: indexPath.row)
        
        // ☘️ 열거형을 사용한 개선
        cell.textLabel?.text = SettingOption.allCases[indexPath.section].rowTitle[indexPath.row]

        return cell
    }
    
    // Header의 Title 설정
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //return settingDataManager.getSectionTitle(at: section)
        
        // ☘️ 열거형을 사용한 개선
        return SettingOption.allCases[section].sectionTitle
    }
    
}
