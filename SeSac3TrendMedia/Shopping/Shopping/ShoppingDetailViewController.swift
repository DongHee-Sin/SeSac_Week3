//
//  ShoppingDetailViewController.swift
//  SeSac3TrendMedia
//
//  Created by 신동희 on 2022/08/23.
//

import UIKit

class ShoppingDetailViewController: UIViewController {

    // MARK: - Propertys
    var shoppingData: Shopping?
    
    @IBOutlet weak var isFinishButton: UIButton!
    @IBOutlet weak var isImportantButton: UIButton!
    
    @IBOutlet weak var shoppingImageView: UIImageView!
    
    
    
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let shoppingData = shoppingData {
            updateUI(data: shoppingData)
        }
    }
    
    
    
    
    // MARK: - Methods
    func updateUI(data: Shopping) {
        navigationItem.title = data.title
        isFinishButton.setImage(data.isFinish ? UIImage(systemName: "checkmark.square.fill") : UIImage(systemName: "checkmark.square"), for: .normal)
        isImportantButton.setImage(data.isImportant ? UIImage(systemName: "star.fill") : UIImage(systemName: "star"), for: .normal)
        
        loadImageFromDocument(fileName: "\(data.objectId)")
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
