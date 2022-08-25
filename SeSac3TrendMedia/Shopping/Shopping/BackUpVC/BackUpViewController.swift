//
//  BackUpViewController.swift
//  SeSac3TrendMedia
//
//  Created by 신동희 on 2022/08/25.
//

import UIKit

import JGProgressHUD
import Zip


class BackUpViewController: UIViewController {

    // MARK: - Propertys
    var backupList: [String] = []
    
    let dateManager = DateFormatterManager()
    
    let hud: JGProgressHUD = {
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Loading"
        hud.detailTextLabel.text = "n% Complete"
        return hud
    }()
    
    
    
    
    // MARK: - Life Cycle
    let backupView = BackUpView()
    override func loadView() {
        self.view = backupView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    
    
    
    // MARK: - Methdos
    func configure() {
        backupView.backupListTableView.delegate = self
        backupView.backupListTableView.dataSource = self
        backupView.backupListTableView.register(BackUpTableViewCell.self, forCellReuseIdentifier: "cell")
        
        backupView.backupButton.addTarget(self, action: #selector(backupButtonTapped), for: .touchUpInside)
        backupView.restoreButton.addTarget(self, action: #selector(restoreButtonTapped), for: .touchUpInside)
        
        setNavigationBar()
    }
    
    
    func setNavigationBar() {
        let dismissButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(dismissButtonTapped))
        navigationController?.navigationBar.tintColor = .darkGray
        navigationItem.leftBarButtonItem = dismissButton
    }
    
    
    @objc func dismissButtonTapped() {
        dismiss(animated: true)
    }
    
    
    func showHUD() {
        view.isUserInteractionEnabled = false
        hud.show(in: self.view)
    }
    
    
    func dismissHUD() {
        view.isUserInteractionEnabled = true
        hud.dismiss(animated: true)
    }
}




// MARK: - TableView Protocol
extension BackUpViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? BackUpTableViewCell else {
            return UITableViewCell()
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}




// MARK: - 백업 & 복구 Method
extension BackUpViewController {
    
    // 백업
    @objc func backupButtonTapped() {
        var urlPaths = [URL]()
        
        guard let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            showAlert(title: "Document 위치에 오류가 있습니다.")
            return
        }
        
        let realmPath = path.appendingPathComponent("default.realm")
        let imagePath = path.appendingPathComponent("image", isDirectory: true)
        
        guard FileManager.default.fileExists(atPath: realmPath.path) else {
            showAlert(title: "백업할 데이터가 없습니다.")
            return
        }
        
        urlPaths.append(contentsOf: [realmPath, imagePath])
        
        do {
            let zipFilePath = try Zip.quickZipFiles(urlPaths, fileName: "SeSac\(dateManager.currentDateString)")
            showActivityViewController(filePath: zipFilePath)
        }
        catch {
            showAlert(title: "파일 압축에 실패했습니다.")
        }
    }
    
    
    func showActivityViewController(filePath: URL) {
        let vc = UIActivityViewController(activityItems: [filePath], applicationActivities: nil)
        present(vc, animated: true)
    }
    
    
    // 복구
    @objc func restoreButtonTapped() {
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.zip], asCopy: true)
        
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        
        present(documentPicker, animated: true)
    }
}




// MARK: - DocumentPicker Protocol
extension BackUpViewController: UIDocumentPickerDelegate {
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print(#function)
    }
    
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        showHUD()
        
        // selectedFileURL : 사용자가 document에서 선택한 "zip파일"의 경로
        guard let selectedFileURL = urls.first else {
            dismissHUD()
            showAlert(title: "선택하신 파일을 찾을 수 없습니다.")
            return
        }
        
        guard let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            dismissHUD()
            showAlert(title: "Document 위치에 오류가 있습니다.")
            return
        }
        
        // 현재 Sandbox의 Document 경로에 "백업했던 zip파일"의 파일명을 append (현재 Sandbox주소로 업데이트)
        let sandboxFileURL = path.appendingPathComponent(selectedFileURL.lastPathComponent)
        
        
        // 현재 Sandbox에 동일한 이름의 zip파일이 있는지 확인
        if FileManager.default.fileExists(atPath: sandboxFileURL.path)  {
            restoreFile(fileURL: sandboxFileURL, documentURL: path)
        }
        else {
            do {
                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
                restoreFile(fileURL: sandboxFileURL, documentURL: path)
            }
            catch {
                dismissHUD()
                showAlert(title: "백업 데이터 복사에 실패했습니다.")
            }
        }
    }
    
    
    func restoreFile(fileURL: URL, documentURL: URL) {
        do {
            try Zip.unzipFile(fileURL, destination: documentURL, overwrite: true, password: nil, progress: { [weak self] progress in
                self?.hud.detailTextLabel.text = "\(progress)% Complete"
            }, fileOutputHandler: { [weak self] unzippedFile in
                self?.dismissHUD()
                self?.showAlert(title: "복구가 완료되었습니다.", handler: { _ in
                    let vc = UIStoryboard(name: "Shopping", bundle: nil).instantiateViewController(withIdentifier: "ShoppingTableViewController")
                    let navi = UINavigationController(rootViewController: vc)
                    self?.changeRootViewController(to: navi)
                })
            })
        }
        catch {
            dismissHUD()
            showAlert(title: "압축 해제에 실패했습니다.")
        }
    }
}
