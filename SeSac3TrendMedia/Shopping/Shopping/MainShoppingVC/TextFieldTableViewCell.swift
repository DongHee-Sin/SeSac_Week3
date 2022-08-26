//
//  TextFieldTableViewCell.swift
//  SeSac3TrendMedia
//
//  Created by 신동희 on 2022/07/19.
//

import UIKit


protocol ShoppingDataDelegate {
    func addMemo(title: String)
    func removeMemo(at index: Int)
    
    func selectImage()
    
    func selectDate()
}


class TextFieldTableViewCell: UITableViewCell {

    // Delegate
    var delegate: ShoppingDataDelegate?
    
    
    // MARK: - Outlet
    @IBOutlet weak var shoppingTextField: UITextField!
    @IBOutlet weak var imageButton: UIButton!
    
    
    // MARK: - Awake From Nib
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        
        shoppingTextField.placeholder = "무엇을 구매하실 건가요?"
        shoppingTextField.borderStyle = .none
        
        setImageButton()
    }
    
    
    func setImageButton() {
        var children: [UIMenuElement] {
            let camera = UIAction(title: "사진 찍기", image: UIImage(systemName: "camera.circle")) {_ in
                print("camera tap")
            }
            
            let library = UIAction(title: "갤러리에서 가져오기", image: UIImage(systemName: "photo.circle")) { [weak self] _ in
                print("갤러리 tap")
                self?.delegate?.selectImage()
            }
            
            return [camera, library]
        }
        
        imageButton.menu = UIMenu(title: "선택하세요", image: nil, identifier: nil, options: .displayInline, children: children)
        imageButton.showsMenuAsPrimaryAction = true
    }
    
    
    @IBAction func addButtonDidTapped(_ sender: UIButton) {
        delegateAddingMemo()
    }
    
    
    @IBAction func shoppingTextFieldReturn(_ sender: UITextField) {
        delegateAddingMemo()
    }
    
    @IBAction func calendarButtonTapped(_ sender: UIButton) {
        delegate?.selectDate()
    }
    
    
    func delegateAddingMemo() {
        guard shoppingTextField.text != "" else {
            return
        }
        delegate?.addMemo(title: shoppingTextField.text!)
        shoppingTextField.text = nil
    }
}
