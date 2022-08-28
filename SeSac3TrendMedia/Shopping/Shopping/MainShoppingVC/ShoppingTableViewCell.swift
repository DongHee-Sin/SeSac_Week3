//
//  ShoppingTableViewCell.swift
//  SeSac3TrendMedia
//
//  Created by 신동희 on 2022/07/19.
//

import UIKit


protocol ButtonActionDelegate {
    func finishButtonTapped(index: Int)
    
    func importantButtonTapped(index: Int)
}


class ShoppingTableViewCell: UITableViewCell {

    // MARK: - Outlet
    @IBOutlet weak var checkMarkButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var shoppingImageView: UIImageView!
    
    
    
    var delegate: ButtonActionDelegate?
    var index: Int?
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
    }
    
    
    
    // MARK: - Methods
    @IBAction func finishButtonTapped(_ sender: UIButton) {
        delegate?.finishButtonTapped(index: index!)
    }
    
    
    @IBAction func importantButtonTapped(_ sender: UIButton) {
        delegate?.importantButtonTapped(index: index!)
    }
    
    
    func updateCell(data: Shopping) {
        titleLabel.text = data.title
        checkMarkButton.setImage(data.isFinish ? UIImage(systemName: "checkmark.square.fill") : UIImage(systemName: "checkmark.square"), for: .normal)
        starButton.setImage(data.isImportant ? UIImage(systemName: "star.fill") : UIImage(systemName: "star"), for: .normal)
    }
}
