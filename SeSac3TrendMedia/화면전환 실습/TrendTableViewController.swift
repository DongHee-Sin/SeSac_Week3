//
//  TrendTableViewController.swift
//  SeSac3TrendMedia
//
//  Created by 신동희 on 2022/07/21.
//

import UIKit

class TrendTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func movieButtonTapped(_ sender: UIButton) {
        // 영화버튼 클릭 > BucketlistTableViewController Present
        
        // 화면전환 : 1. 스토리보드 파일 찾기  2. 스토리보드 내부의 뷰컨트롤러 찾기 3. 화면 전환
        
        // 1. 스토리보드 찾기
        // name: 스토리보드 파일 이름
        // bundle: 현재 있는 모듈(??)
        // storyboard.instantiate ... 이건 같은 스토리보드 파일에 있을 경우에만 사용 가능한듯
        let sb = UIStoryboard(name: "Trend", bundle: nil)

        // 2. 뷰컨트롤러 찾기
        guard let vc = sb.instantiateViewController(withIdentifier: BucketListTableViewController.identifier) as? BucketListTableViewController else {
            return
        }

        vc.placeHolder = sender.currentTitle
        
        // 3. 화면 전환
        self.present(vc, animated: true)
    }
    
    
    
    @IBAction func dramaButtonTapped(_ sender: UIButton) {
        
        // 1.
        let sb = UIStoryboard(name: "Trend", bundle: nil)

        // 2.
        guard let vc = sb.instantiateViewController(withIdentifier: BucketListTableViewController.identifier) as? BucketListTableViewController else {
            return
        }

        
        // 2.5 : persent style 변경
        vc.modalPresentationStyle = .fullScreen

        vc.placeHolder = sender.currentTitle
        
        // 3.
        self.present(vc, animated: true)
        
    }
    
    
    @IBAction func bookButtonTapped(_ sender: UIButton) {
        
        // 1.
        let sb = UIStoryboard(name: "Trend", bundle: nil)

        // 2.
        guard let vc = sb.instantiateViewController(withIdentifier: BucketListTableViewController.identifier) as? BucketListTableViewController else {
            return
        }

        vc.placeHolder = sender.currentTitle
        
        // 2.5 : navi 붙이기 / 임베드
        let nav = UINavigationController(rootViewController: vc)

        
        // 2.5
        nav.modalPresentationStyle = .fullScreen

        
        // 3.
        self.present(nav, animated: true)
        
    }
    
}
