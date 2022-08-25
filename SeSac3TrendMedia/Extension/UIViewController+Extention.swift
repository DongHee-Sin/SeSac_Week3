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
    
    
    func showAlert(title: String, button: String = "확인", handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        let ok = UIAlertAction(title: button, style: .default, handler: handler)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    
    func changeRootViewController(to rootVC: UIViewController) {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        sceneDelegate?.window?.rootViewController = rootVC
        sceneDelegate?.window?.makeKeyAndVisible()
    }
}
