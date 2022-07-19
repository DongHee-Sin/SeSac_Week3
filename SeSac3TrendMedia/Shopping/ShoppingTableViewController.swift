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
    
    
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetting()
    }

    
   
    // MARK: - Methods
    func initialSetting() {
        searchTextField.placeholder = "무엇을 구매하실 건가요?"
        searchTextField.borderStyle = .none
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingModel.getListCount()
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingTableViewCell", for: indexPath) as! ShoppingTableViewCell
        
        let data = shoppingModel.getMemo(at: indexPath.row)
        
        cell.titleLabel.text = data.title
        cell.checkMarkButton.setImage(data.isSelected ? UIImage(systemName: "checkmark.square.fill") : UIImage(systemName: "checkmark.square"), for: .normal)
        cell.starButton.setImage(data.isImportant ? UIImage(systemName: "star.fill") : UIImage(systemName: "star"), for: .normal)
        
        return cell
    }
}
