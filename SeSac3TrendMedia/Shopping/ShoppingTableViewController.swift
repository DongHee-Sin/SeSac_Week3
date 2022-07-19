//
//  ShoppingTableViewController.swift
//  SeSac3TrendMedia
//
//  Created by 신동희 on 2022/07/19.
//

import UIKit

class ShoppingTableViewController: UITableViewController {
    
    // MARK: - Propertys
    var shoppingModel = ShoppingListModel()
    
    
    
    // MARK: - Outlet
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var headerView: UIView!
    
    
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetting()
    }

    
   
    // MARK: - Methods
    func initialSetting() {
        searchTextField.placeholder = "무엇을 구매하실 건가요?"
        searchTextField.borderStyle = .none
        
        tableView.keyboardDismissMode = .onDrag
        
        headerView.layer.cornerRadius = headerView.frame.height / 7
    }
    

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingModel.getListCount()
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingTableViewCell", for: indexPath) as! ShoppingTableViewCell
        
        let data = shoppingModel.getMemo(at: indexPath.row)
        
        cell.selectionStyle = .none
        cell.titleLabel.text = data.title
        cell.checkMarkButton.setImage(data.isSelected ? UIImage(systemName: "checkmark.square.fill") : UIImage(systemName: "checkmark.square"), for: .normal)
        cell.starButton.setImage(data.isImportant ? UIImage(systemName: "star.fill") : UIImage(systemName: "star"), for: .normal)
        
        return cell
    }
}
