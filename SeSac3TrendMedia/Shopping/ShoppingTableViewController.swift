//
//  ShoppingTableViewController.swift
//  SeSac3TrendMedia
//
//  Created by 신동희 on 2022/07/19.
//

import UIKit

class ShoppingTableViewController: UITableViewController {
    
    // MARK: - Propertys
    var shoppingListManager = ShoppingListManager()
    
    
    
    // MARK: - Outlet
    @IBOutlet weak var shoppingTextField: UITextField!
    
    @IBOutlet weak var headerView: UIView!
    
    
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetting()
    }

    
   
    // MARK: - Methods
    func initialSetting() {
        shoppingTextField.placeholder = "무엇을 구매하실 건가요?"
        shoppingTextField.borderStyle = .none
        
        tableView.keyboardDismissMode = .onDrag
        
        headerView.layer.cornerRadius = headerView.frame.height / 7
    }
    

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingListManager.getListCount()
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingTableViewCell", for: indexPath) as! ShoppingTableViewCell
        
        let data = shoppingListManager.getMemo(at: indexPath.row)
        
        cell.selectionStyle = .none
        cell.titleLabel.text = data.title
        cell.checkMarkButton.setImage(data.isSelected ? UIImage(systemName: "checkmark.square.fill") : UIImage(systemName: "checkmark.square"), for: .normal)
        cell.starButton.setImage(data.isImportant ? UIImage(systemName: "star.fill") : UIImage(systemName: "star"), for: .normal)
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            shoppingListManager.removeMemo(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    
    @IBAction func addButtonDidTapped(_ sender: UIButton) {
        addShoppingMemo()
    }
    
    
    @IBAction func shoppingTextFieldReturn(_ sender: UITextField) {
        addShoppingMemo()
    }
    
    
    func addShoppingMemo() {
        guard let title = shoppingTextField.text else {
            return
        }
        shoppingListManager.addMemo(title: title)
        tableView.reloadData()
        shoppingTextField.text = nil
    }
}
