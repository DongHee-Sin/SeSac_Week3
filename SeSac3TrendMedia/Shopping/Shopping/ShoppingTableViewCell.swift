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
        // Initialization code
    }
    
    
    @IBAction func finishButtonTapped(_ sender: UIButton) {
        delegate?.finishButtonTapped(index: index!)
    }
    
    
    @IBAction func importantButtonTapped(_ sender: UIButton) {
        delegate?.importantButtonTapped(index: index!)
    }
    
    
    func loadImageFromDocument(fileName: String) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileURL = documentDirectory.appendingPathComponent("\(fileName).jpg")
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            shoppingImageView.image = UIImage(contentsOfFile: fileURL.path)
        }else {
            shoppingImageView.image = UIImage(systemName: "star.fill")
        }
    }
}
