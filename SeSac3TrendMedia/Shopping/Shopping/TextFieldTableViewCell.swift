//
//  TextFieldTableViewCell.swift
//  SeSac3TrendMedia
//
//  Created by 신동희 on 2022/07/19.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell {

    // Delegate
    var delegate: ShoppingDataDelegate?
    
    
    // MARK: - Outlet
    @IBOutlet weak var shoppingTextField: UITextField!
    
    
    
    // MARK: - Awake From Nib
    override func awakeFromNib() {
        super.awakeFromNib()
        
        shoppingTextField.placeholder = "무엇을 구매하실 건가요?"
        shoppingTextField.borderStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
    @IBAction func addButtonDidTapped(_ sender: UIButton) {
        delegateAddingMemo()
    }
    
    
    @IBAction func shoppingTextFieldReturn(_ sender: UITextField) {
        delegateAddingMemo()
    }
    
    
    func delegateAddingMemo() {
        guard let title = shoppingTextField.text else {
            return
        }
        delegate?.addMemo(title: title)
        shoppingTextField.text = nil
    }
}
