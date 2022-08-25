//
//  BackUpViewController.swift
//  SeSac3TrendMedia
//
//  Created by 신동희 on 2022/08/25.
//

import UIKit
import Zip

class BackUpViewController: UIViewController {

    // MARK: - Propertys
    var backupList: [String] = []
    
    let dateManager = DateFormatterManager()
    
    
    
    
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
        
        guard FileManager.default.fileExists(atPath: realmPath.path) else {
            showAlert(title: "백업할 데이터가 없습니다.")
            return
        }
        
        urlPaths.append(realmPath)
        
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
        // selectedFileURL : 사용자가 document에서 선택한 zip파일의 경로
        guard let selectedFileURL = urls.first else {
            showAlert(title: "선택하신 파일을 찾을 수 없습니다.")
            return
        }
        
        guard let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            showAlert(title: "Document 위치에 오류가 있습니다.")
            return
        }
        
        let sandboxFileURL = path.appendingPathComponent(selectedFileURL.lastPathComponent)
        
        if FileManager.default.fileExists(atPath: sandboxFileURL.path) {
            do {
                try Zip.unzipFile(sandboxFileURL, destination: path, overwrite: true, password: nil, progress: { progress in
                    print("progress : \(progress)")
                }, fileOutputHandler: { [weak self] unzippedFile in
                    self?.showAlert(title: "복구가 완료되었습니다.", handler: { [weak self] _ in
                        let vc = UIStoryboard(name: "Shopping", bundle: nil).instantiateViewController(withIdentifier: "ShoppingTableViewController")
                        let navi = UINavigationController(rootViewController: vc)
                        self?.changeRootViewController(to: navi)
                    })
                })
            }
            catch {
                showAlert(title: "압축 해제에 실패했습니다.")
            }
            
        }
        else {
            do {
                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
                
                try Zip.unzipFile(sandboxFileURL, destination: path, overwrite: true, password: nil, progress: { progress in
                    print("progress : \(progress)")
                }, fileOutputHandler: { [weak self] unzippedFile in
                    self?.showAlert(title: "복구가 완료되었습니다.", handler: { _ in
                        let vc = UIStoryboard(name: "Shopping", bundle: nil).instantiateViewController(withIdentifier: "ShoppingTableViewController")
                        let navi = UINavigationController(rootViewController: vc)
                        self?.changeRootViewController(to: navi)
                    })
                })
            }
            catch {
                showAlert(title: "압축 해제에 실패했습니다.")
            }
            
        }
    }
}
