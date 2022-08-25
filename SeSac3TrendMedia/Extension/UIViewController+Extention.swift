//
//  UIViewController+Extention.swift
//  SeSac3TrendMedia
//
//  Created by 신동희 on 2022/07/19.
//

import UIKit


extension UIViewController {
    
    func setBackgroundColor() {
        view.backgroundColor = .orange
    }
    
    
    func showAlert(title: String, button: String = "확인") {
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        let ok = UIAlertAction(title: button, style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
}
