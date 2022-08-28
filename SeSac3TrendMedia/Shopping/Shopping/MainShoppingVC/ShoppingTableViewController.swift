//
//  ShoppingTableViewController.swift
//  SeSac3TrendMedia
//
//  Created by 신동희 on 2022/07/19.
//

import UIKit
import PhotosUI
import RealmSwift


class ShoppingTableViewController: UITableViewController {

    // MARK: - Propertys
    var shoppingListManager = RealmManager(Shopping.self, byKeyPath: "title", ascending: true)
    var documentManager = DocumentManager()


    var phpicker: PHPickerViewController = {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 1
        configuration.filter = .images

        let phpickerVC = PHPickerViewController(configuration: configuration)

        return phpickerVC
    }()


    var selectedImage: UIImage?

    var selectedDate: String?

    var notificationToken: NotificationToken?




    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()

        documentManager.createImageDirectory()

        initialSetting()

        shoppingListManager.addObserver { [weak self] in
            self?.tableView.reloadData()
        }
    }




    // MARK: - Methods

    func initialSetting() {
        phpicker.delegate = self

        tableView.keyboardDismissMode = .onDrag

        setBarButton()
    }


    func setBarButton() {

        // left
        let backupButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.down"), style: .plain, target: self, action: #selector(backupButtonTapped))
        navigationItem.leftBarButtonItem = backupButton


        // right
        let sortByTitle = UIAction(title: "Title 기준 정렬", image: UIImage(systemName: "textformat"), identifier: nil) { [weak self] _ in
            guard let self = self else { return }
            self.selectedSortBy(by: "title")
        }

        let sortByImportant = UIAction(title: "중요도 기준 정렬", image: UIImage(systemName: "star.fill"), identifier: nil) { [weak self] _ in
            guard let self = self else { return }
            self.selectedSortBy(by: "isImportant")
        }

        let sortByFinished = UIAction(title: "완료 기준 정렬", image: UIImage(systemName: "checkmark.square.fill"), identifier: nil) { [weak self] _ in
            guard let self = self else { return }
            self.selectedSortBy(by: "isFinish")
        }

        let sortBarButton = UIBarButtonItem(title: nil,
                                            image: UIImage(systemName: "arrow.up.arrow.down.circle"),
                                            primaryAction: nil,
                                            menu: UIMenu(title: "정렬 기준 선택", subtitle: nil, image: nil, identifier: nil, options: .displayInline, children: [sortByTitle, sortByImportant, sortByFinished]))

        navigationItem.rightBarButtonItem = sortBarButton

        navigationController?.navigationBar.tintColor = .darkGray
    }


    @objc func backupButtonTapped() {
        let vc = BackUpViewController()
        let navi = UINavigationController(rootViewController: vc)
        navi.modalPresentationStyle = .fullScreen
        present(navi, animated: true)
    }


    func selectedSortBy(by sortBY: String) {
        shoppingListManager.changeSort(byKeyPath: sortBY, ascending: true)
        tableView.reloadData()
    }




    // MARK: - TableView Methods
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else {
            return shoppingListManager.count
        }
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldTableViewCell", for: indexPath) as! TextFieldTableViewCell

            cell.delegate = self

            if let selectedImage = selectedImage {
                cell.imageButton.setImage(selectedImage, for: .normal)
            }else {
                cell.imageButton.setImage(UIImage(systemName: "photo.circle"), for: .normal)
            }

            return cell

        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingTableViewCell", for: indexPath) as! ShoppingTableViewCell

            let data = shoppingListManager.getData(at: indexPath.row)

            cell.delegate = self
            cell.index = indexPath.row
            
            cell.updateCell(data: data)
            cell.shoppingImageView.image = DocumentManager().loadImageFromDocument(fileName: "\(data.objectId)")

            return cell
        }
    }


    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 80 : 120
    }


    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section != 0 ? true : false
    }


    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if indexPath.section != 0 {
            if editingStyle == .delete {
                do {
                    documentManager.removeImageFromDocument(fileName: "\(shoppingListManager.getData(at: indexPath.row).objectId)")
                    try shoppingListManager.remove(at: indexPath.row)
                }
                catch let error {
                    print(error)
                }
            }
        }
    }


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section != 0 else { return }

        guard let vc = storyboard?.instantiateViewController(withIdentifier: "ShoppingDetailViewController") as? ShoppingDetailViewController else {
            return
        }

        let data = shoppingListManager.getData(at: indexPath.row)
        vc.shoppingData = data

        navigationController?.pushViewController(vc, animated: true)
    }

}



// MARK: - ShoppingData Delegate
extension ShoppingTableViewController: ShoppingDataDelegate {

    func addMemo(title: String) {
        var title = title
        if let selectedDate = selectedDate {
            title.append("\n\(selectedDate)")
        }

        let data = Shopping(title: title)
        do {
            try shoppingListManager.write(data)
            if let selectedImage = selectedImage {
                documentManager.saveImageToDocument(fileName: "\(data.objectId)", image: selectedImage)
            }
        }
        catch let error {
            print(error)
        }

        selectedImage = nil
        selectedDate = nil
    }

    func removeMemo(at index: Int) {
        do {
            try shoppingListManager.remove(at: index)
        }
        catch let error {
            print(error)
        }
    }



    func selectImage() {
        present(phpicker, animated: true)
    }

    func selectDate() {
        let sb = UIStoryboard(name: "Shopping", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "CalendarViewController") as? CalendarViewController else { return }

        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium()]
        }

        vc.handler = { [weak self] (date: String) in
            self?.selectedDate = date
        }

        present(vc, animated: true)
    }

}



// MARK: - ButtonAction Delegate
extension ShoppingTableViewController: ButtonActionDelegate {
    func finishButtonTapped(index: Int) {
        do {
            try shoppingListManager.update(at: index) { data in
                data.isFinish.toggle()
            }
        }
        catch let error {
            print(error)
        }
    }

    func importantButtonTapped(index: Int) {
        do {
            try shoppingListManager.update(at: index) { data in
                data.isImportant.toggle()
            }
        }
        catch let error {
            print(error)
        }
    }
}




// MARK: - PHPicker
extension ShoppingTableViewController: PHPickerViewControllerDelegate {

    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        if let itemProvider = results.first?.itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                guard let selectedImage = image as? UIImage else { return }

                DispatchQueue.main.async {
                    self?.selectedImage = selectedImage
                    self?.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
                    self?.dismiss(animated: true)
                }
            }
        }
    }


}
