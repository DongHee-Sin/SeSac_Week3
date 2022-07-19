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
    
    
    func showAlert() {
        let alert = UIAlertController(title: "타이틀", message: "", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
}
