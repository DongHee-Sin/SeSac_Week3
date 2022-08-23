//
//  ShoppingTableViewController.swift
//  SeSac3TrendMedia
//
//  Created by 신동희 on 2022/07/19.
//

import UIKit


protocol ShoppingDataDelegate {
    func addMemo(title: String)
    func removeMemo(at index: Int)
}


class ShoppingTableViewController: UITableViewController {
    
    // MARK: - Propertys
    var shoppingListManager = ShoppingListManager()

    
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetting()
    }

    
   
    // MARK: - Methods
    func initialSetting() {
        tableView.keyboardDismissMode = .onDrag
        
        setBarButton()
    }
    
    func setBarButton() {
        let sortByTitle = UIAction(title: "Title 기준 정렬", image: UIImage(systemName: "textformat"), identifier: nil) { [weak self] _ in
            guard let self = self else { return }
            self.selectedSortBy(by: .title)
        }
        
        let sortByImportant = UIAction(title: "중요도 기준 정렬", image: UIImage(systemName: "star.fill"), identifier: nil) { [weak self] _ in
            guard let self = self else { return }
            self.selectedSortBy(by: .important)
        }
        
        let sortByFinished = UIAction(title: "완료 기준 정렬", image: UIImage(systemName: "checkmark.square.fill"), identifier: nil) { [weak self] _ in
            guard let self = self else { return }
            self.selectedSortBy(by: .finished)
        }
        
        let defaultSort = UIAction(title: "기본 정렬", image: UIImage(systemName: "circle.dashed"), identifier: nil) { [weak self] _ in
            guard let self = self else { return }
            self.selectedSortBy(by: .none)
        }
        
        let sortBarButton = UIBarButtonItem(title: nil,
                                            image: UIImage(systemName: "arrow.up.arrow.down.circle"),
                                            primaryAction: nil,
                                            menu: UIMenu(title: "정렬 기준 선택", subtitle: nil, image: nil, identifier: nil, options: .displayInline, children: [sortByTitle, sortByImportant, sortByFinished, defaultSort]))
        
        sortBarButton.tintColor = .darkGray
        
        navigationItem.rightBarButtonItem = sortBarButton
    }
    
    
    func selectedSortBy(by sortBY: SortBy) {
        shoppingListManager.currentSortBy = sortBY
        shoppingListManager.readData()
        tableView.reloadData()
    }
    

    
    
    // MARK: - TableView Methods
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else {
            return shoppingListManager.count
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldTableViewCell", for: indexPath) as! TextFieldTableViewCell
            
            cell.selectionStyle = .none
            cell.delegate = self
            
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingTableViewCell", for: indexPath) as! ShoppingTableViewCell
            
            let data = shoppingListManager.getMemo(at: indexPath.row)
            
            cell.selectionStyle = .none
            cell.titleLabel.text = data.title
            cell.checkMarkButton.setImage(data.isFinish ? UIImage(systemName: "checkmark.square.fill") : UIImage(systemName: "checkmark.square"), for: .normal)
            cell.starButton.setImage(data.isImportant ? UIImage(systemName: "star.fill") : UIImage(systemName: "star"), for: .normal)
            
            cell.delegate = self
            cell.index = indexPath.row
            
            return cell
        }
    }
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section != 0 ? true : false
    }
    

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if indexPath.section != 0 {
            if editingStyle == .delete {
                shoppingListManager.removeMemo(at: indexPath.row)
                tableView.reloadData()
            }
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "ShoppingDetailViewController") as? ShoppingDetailViewController else {
            return
        }
        
        let data = shoppingListManager.getMemo(at: indexPath.row)
        vc.shoppingData = data
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}



// MARK: - CR Delegate
extension ShoppingTableViewController: ShoppingDataDelegate {
    func addMemo(title: String) {
        shoppingListManager.addMemo(title: title)
        tableView.reloadData()
    }
    
    func removeMemo(at index: Int) {
        shoppingListManager.removeMemo(at: index)
        tableView.reloadData()
    }
    
}



// MARK: - ButtonAction Delegate
extension ShoppingTableViewController: ButtonActionDelegate {
    func finishButtonTapped(index: Int) {
        shoppingListManager.finishTapped(index: index)
        tableView.reloadData()
    }
    
    func importantButtonTapped(index: Int) {
        shoppingListManager.importantTapped(index: index)
        tableView.reloadData()
    }
}
