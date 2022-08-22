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
    }
    

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
    
}


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
