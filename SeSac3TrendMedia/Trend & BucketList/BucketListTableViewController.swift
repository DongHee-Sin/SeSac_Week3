//
//  BucketListTableViewController.swift
//  SeSac3TrendMedia
//
//  Created by 신동희 on 2022/07/19.
//

import UIKit

class BucketListTableViewController: UITableViewController {

    var list = ["범죄도시2", "탑건", "토르"]
    
    @IBOutlet weak var userTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 80
        
        list.append("마녀")
        list.append("아이언맨")
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 매개변수 for: 는 indexPath값을 다르게 가져가고 싶을 때 사용
        // 동일하게 indexPath를 가져간다면 생략해도 괜찮다.
        let cell = tableView.dequeueReusableCell(withIdentifier: "BucketListTableViewCell", for: indexPath) as! BucketListTableViewCell
        
        cell.bucketListLabel.text = list[indexPath.row]
        cell.bucketListLabel.font = .boldSystemFont(ofSize: 13)
        
        return cell
    }
    
    
    @IBAction func userTextFieldReturn(_ sender: UITextField) {
        list.append(sender.text!)
        
        // 데이터가 변동되는 시점에 TableView를 다시 그리기
        tableView.reloadData()
        
//        tableView.reloadSections(IndexSet(integer: 0), with: .fade)
//        tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // 우측 스와이프 디폴트 가능 : commit editingStyle
    // canEditRowAt이 있어야 사용 가능
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // 배열(데이터) 삭제 후 테이블뷰 갱신
            list.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    
    
//    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        <#code#>
//    }
//
//    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//
//    }
}
