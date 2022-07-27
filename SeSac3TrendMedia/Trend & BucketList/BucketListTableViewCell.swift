//
//  BucketListTableViewCell.swift
//  SeSac3TrendMedia
//
//  Created by 신동희 on 2022/07/19.
//

import UIKit

class BucketListTableViewCell: UITableViewCell {

    // 오타방지
    static let identifier = "BucketListTableViewCell"
    
    @IBOutlet weak var checkBoxButton: UIButton! {
        didSet {
            checkBoxButton.setTitle("", for: .normal)
        }
    }
    @IBOutlet weak var bucketListLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
}
