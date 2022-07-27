//
//  BucketListTableViewController.swift
//  SeSac3TrendMedia
//
//  Created by 신동희 on 2022/07/19.
//

import UIKit


struct Todo {
    var title: String
    var done: Bool
}


class BucketListTableViewController: UITableViewController {

    static let identifier = "BucketListTableViewController"
    
    // list 프로퍼티가 추가, 삭제 등 변경 되고 나서 테이블뷰를 항상 갱신!
    var list = [Todo(title: "범죄도시", done: false), Todo(title: "탑건", done: false)] {
        didSet {
            // 데이터가 변하면 싹다 리로드 시키므로 하나만 리로드할 필요가 있을 때 비요율적일 수 있다.
            //tableView.reloadData()
            print("list가 변경됨 \(list)")
        }
    }
    
    @IBOutlet weak var userTextField: UITextField! {
        didSet {
            userTextField.textColor = .systemRed
            print("텍스트필드 DidSet")
        }
    }
    
    var placeHolder: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // navigation 설정
        navigationItem.title = "버킷리스트"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonTapped))
        
        userTextField.placeholder = "\(placeHolder ?? "검색어")를 입력해주세요"
        
        tableView.rowHeight = 80
        
        list.append(Todo(title: "마녀", done: true))
        list.append(Todo(title: "아이언맨", done: true))
    }
    
    
    @objc func closeButtonTapped() {
        self.dismiss(animated: true)
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 매개변수 for: 는 indexPath값을 다르게 가져가고 싶을 때 사용
        // 동일하게 indexPath를 가져간다면 생략해도 괜찮다.
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BucketListTableViewCell.identifier, for: indexPath) as? BucketListTableViewCell else {
            return UITableViewCell()
        }
        
        cell.bucketListLabel.text = list[indexPath.row].title
        cell.bucketListLabel.font = .boldSystemFont(ofSize: 13)
        
        cell.checkBoxButton.tag = indexPath.row
        cell.checkBoxButton.addTarget(self, action: #selector(checkboxButtonTapped(sender:)), for: .touchUpInside)
        cell.checkBoxButton.setImage(list[indexPath.row].done ? UIImage(systemName: "checkmark.square.fill") : UIImage(systemName: "checkmark.square"), for: .normal)
        
        return cell
    }
    
    
    @objc func checkboxButtonTapped(sender: UIButton) {
        print("\(sender.tag)번째 버튼 클릭!")
        
        // 배열 index를 찾아서 done를 바꿔야된다. 그리고 테이블뷰 갱신
        // 여기서 값 변경, List가 변경되므로 자동으로 reload()
        list[sender.tag].done.toggle()
        
        // 필요한 셀만 리로드하므로 효율적임
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .fade)
        
        // 재사용 셀 오류 확인용 코드
        //sender.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
    }
    
    
    @IBAction func userTextFieldReturn(_ sender: UITextField) {
        
//        // case 2. if let
//        if let value = sender.text?.trimmingCharacters(in: .whitespacesAndNewlines), !value.isEmpty, (2...6).contains(value.count) {
//            list.append(value)
//            tableView.reloadData()   // 데이터가 변동되는 시점에 TableView를 다시 그리기
//        }else {
//            // Alert, Toast를 통해 바인딩이 실패했음을 알려줘야 함
//        }
//
//        // case 3. guard let
//        guard let value = sender.text?.trimmingCharacters(in: .whitespacesAndNewlines), !value.isEmpty, (2...6).contains(value.count) else {
//            // Alert, Toast를 통해 바인딩이 실패했음을 알려줘야 함
//            return
//        }
        
//        list.append(value)
        list.append(Todo(title: sender.text!, done: false))
        //tableView.reloadData()
        
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
