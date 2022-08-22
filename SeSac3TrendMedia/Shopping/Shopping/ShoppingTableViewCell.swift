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
    
    var delegate: ButtonActionDelegate?
    var index: Int?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
    @IBAction func finishButtonTapped(_ sender: UIButton) {
        delegate?.finishButtonTapped(index: index!)
    }
    
    
    @IBAction func importantButtonTapped(_ sender: UIButton) {
        delegate?.importantButtonTapped(index: index!)
    }
}
