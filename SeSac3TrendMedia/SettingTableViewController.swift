//
//  SettingTableViewController.swift
//  SeSac3TrendMedia
//
//  Created by 신동희 on 2022/07/18.
//

import UIKit

class SettingTableViewController: UITableViewController {

    var birthdayFriends = ["뽀로로", "고래밥", "모구리", "스노기", "신데렐라"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    // 테이블뷰를 다이나믹으로 설정하면 필요한 것
    
    // 섹션의 개수(옵션)
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    
    // Header Title
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "생일인 친구"
        }else if section == 1 {
            return "즐겨찾기"
        }else if section == 2 {
            return "친구 10명"
        }else {
            return ""
        }
    }
    
    
    // Footer Title
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "푸터"
    }
    
    
    // 1. 셀의 갯수 (필수)
    // ex. 카톡 100명 > 셀 100개, 3000명 > 3000개
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return birthdayFriends.count
        }else if section == 1 {
            return 2
        }else if section == 2 {
            return 10
        }else {
            return 5
        }
    }
    
    
    
    // 2. 셀의 디자인과 데이터 (필수)
    // ex. 카톡 이점팔, 프로필 사진, 상태 메시지 등
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 여기서 복붙하는 효과가 발생
        // withIdentifier : 어떤 셀을 사용할지
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell")!
        
        
        if indexPath.section == 0 {
            cell.textLabel?.text = birthdayFriends[indexPath.row]
            cell.textLabel?.textColor = .green
            cell.textLabel?.font = .boldSystemFont(ofSize: 15)
        }else if indexPath.section == 1 {
            cell.textLabel?.text = "2번 인덱스 텍스트"
            cell.textLabel?.textColor = .red
            cell.textLabel?.font = .boldSystemFont(ofSize: 20)
        }else if indexPath.section == 2 {
            cell.textLabel?.text = "3번 인덱스 텍스트"
            cell.textLabel?.textColor = .brown
            cell.textLabel?.font = .boldSystemFont(ofSize: 25)
        }
//        else {
//            cell.textLabel?.text = "그 외"
//            cell.textLabel?.textColor = .green
//            cell.textLabel?.font = .boldSystemFont(ofSize: 20)
//        }
        
        return cell
    }
}
