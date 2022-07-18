//
//  Case2SettingTableViewController.swift
//  SeSac3TrendMedia
//
//  Created by 신동희 on 2022/07/18.
//

import UIKit

class KakaoSettingTableViewController: UITableViewController {

    // MARK: - Propertys
    let sectionTitle: [String] = ["전체 설정", "개인 설정", "기타"]
    
    let settingInfo: [[String]] = [
        ["공지사항", "실험실", "버전 정보"],
        ["개인/보안", "알림", "채팅", "멀티프로필"],
        ["고객센터/도움말"]
    ]
    
    
    
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    // MARK: - Table view data source

    // 섹션의 개수
    override func numberOfSections(in tableView: UITableView) -> Int {
        return settingInfo.count
    }

    // 섹션별 셀의 개수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingInfo[section].count
    }

    // 사용할 Cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell") else {
            return UITableViewCell()
        }

        cell.textLabel?.text = settingInfo[indexPath.section][indexPath.row]

        return cell
    }
    
    // Header의 Title 설정
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
}
