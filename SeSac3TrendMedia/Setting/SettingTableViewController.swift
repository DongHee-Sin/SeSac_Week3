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
        
        tableView.rowHeight = 80    // 기본 높이 : 44
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
        
        print("cellForRowAt", indexPath)
        
        
        // dequeueReusableCell() 여기서 복붙하는 효과가 발생 (재사용)
        // withIdentifier : 어떤 셀을 사용할지
        if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "rightDetailCell")!
            
            cell.textLabel?.text = "2번 인덱스 텍스트"
            cell.textLabel?.textColor = .red
            cell.textLabel?.font = .boldSystemFont(ofSize: 20)
            
            cell.detailTextLabel?.text = "디테일 레이블"

            
            // indexPath.row % 2 == 0, 1
            
            // 1. if문으로 분기처리
//            if indexPath.row % 2 == 0 {
//                cell.imageView?.image = UIImage(systemName: "star")
//                cell.backgroundColor = .lightGray
//            }else {
//                cell.imageView?.image = UIImage(systemName: "star.fill")
//                cell.backgroundColor = .white
//            }
            
            // 2. 삼항연산자로 분기처리 (간단한 처리에 사용하는게 좋음)
            cell.imageView?.image = indexPath.row % 2 == 0 ? UIImage(systemName: "star") : UIImage(systemName: "star.fill")
            cell.backgroundColor = indexPath.row % 2 == 0 ? .lightGray : .white

            
            return cell
        }else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell")!
            
            if indexPath.section == 0 {
                cell.textLabel?.text = birthdayFriends[indexPath.row]
                cell.textLabel?.textColor = .green
                cell.textLabel?.font = .boldSystemFont(ofSize: 15)
            }else if indexPath.section == 1 {
                cell.textLabel?.text = "2번 인덱스 텍스트"
                cell.textLabel?.textColor = .red
                cell.textLabel?.font = .boldSystemFont(ofSize: 20)
            }
            
            return cell
        }
    }
    
    
    // 셀의 높이 (옵션, 빈도 높음) (feat. tableView.rowHeight)
    // Cell별로, Section별로 다른 높이를 부여하고 싶을 때
    // View가 메모리에 올라온 후 실행되는 viewDIdLoad()에 작성하는 높이 설정보다 여기서 작성한 함수가 더 우선함 (실행시점이 더 늦음)
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath == [0, 0] {
            return 400
        }else {
            return 44
        }
    }
}
