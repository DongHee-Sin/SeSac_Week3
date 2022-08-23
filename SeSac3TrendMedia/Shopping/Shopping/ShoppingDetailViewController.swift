//
//  ShoppingDetailViewController.swift
//  SeSac3TrendMedia
//
//  Created by 신동희 on 2022/08/23.
//

import UIKit

class ShoppingDetailViewController: UIViewController {

    var shoppingData: Shopping?
    
    @IBOutlet weak var isFinishButton: UIButton!
    @IBOutlet weak var isImportantButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let shoppingData = shoppingData {
            updateUI(data: shoppingData)
        }
    }
    
    
    func updateUI(data: Shopping) {
        navigationItem.title = data.title
        isFinishButton.setImage(data.isFinish ? UIImage(systemName: "checkmark.square.fill") : UIImage(systemName: "checkmark.square"), for: .normal)
        isImportantButton.setImage(data.isImportant ? UIImage(systemName: "star.fill") : UIImage(systemName: "star"), for: .normal)
    }
}
